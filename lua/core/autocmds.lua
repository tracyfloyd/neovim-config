local augroup = vim.api.nvim_create_augroup('UserConfig', {})

-- Legacy .NET projects live on NTFS inside the Parallels "Windows 11" VM and are
-- mounted on the Mac over SMB at ~/mnt/win. Buffers on that mount need a few
-- editing defaults relaxed -- see the "Windows VM over SMB" section below.
local win_mount = vim.fn.expand('~/mnt/win')

local function on_win_mount(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  return name ~= '' and vim.startswith(name, win_mount .. '/')
end

-- oil, fugitive and grug-far all back their buffers with a URI rather than a path
-- (oil:///Users/..., fugitive://...). Write-time autocmds that treat the buffer name
-- as a filesystem path have to skip those: 'mkdir -p' on an oil URI creates a literal
-- "oil:" directory tree under the cwd, which macOS then displays as "oil/".
--
-- The scheme match is the arm that catches oil: despite oil setting 'acwrite' in
-- view.lua, its buffers report buftype="" by the time BufWritePre fires, so a buftype
-- check alone does not stop this. The buftype check still earns its place for the
-- special buffers that do set it (quickfix, help, terminal, nofile scratch buffers).
local function is_real_file_buf(bufnr)
  bufnr = bufnr or 0
  if vim.bo[bufnr].buftype ~= '' then
    return false
  end
  local name = vim.api.nvim_buf_get_name(bufnr)
  return not name:match('^%a[%w+.-]*://')
end

-- ======================================================================================
-- Text Editing

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Trim trailing whitespace on save',
  group = augroup,
  pattern = '*',
  callback = function(ev)
    if not is_real_file_buf(ev.buf) then
      return
    end
    -- [ \t\r] rather than \s: Vim's \s is space and tab only, never CR. A file with
    -- mixed endings is read as 'unix', which leaves literal CRs in the buffer text --
    -- and after/ftplugin/{cs,razor}.lua then force 'dos', appending another CR on
    -- write. Without the \r here that silently produces \r\r\n.
    --
    -- keeppatterns and the save/restore keep the substitution from clobbering the
    -- cursor, the scroll position and the last-search register on every save.
    local view = vim.fn.winsaveview()
    local search = vim.fn.getreg('/')
    vim.cmd([[keeppatterns %s/[ \t\r]\+$//e]])
    vim.fn.setreg('/', search)
    vim.fn.winrestview(view)
  end,
})

-- Highlight when yanking text
-- See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Nvim terminal customizations
vim.api.nvim_create_autocmd('TermOpen', {
  desc = 'Customize Nvim Terminal',
  group = augroup,
  callback = function()
    -- opt_local, not opt: 'number' and 'relativenumber' are window-local, and
    -- setting them globally here turns line numbers off for every window
    -- opened afterwards, not just the terminal.
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    local filetype = vim.bo.filetype
    if filetype and filetype ~= '' then
      pcall(vim.treesitter.start)
    end
  end,
})

-- ======================================================================================
-- LSP
-- Runs when an LSP attaches to a buffer.
-- When a file is opened and associated with an LSP, this function
-- will be executed to configure the current buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- See `:help vim.lsp.*` for documentation on any of the below functions.
    --
    -- No <leader>d diagnostic float here: nvim binds <C-W>d to "show
    -- diagnostics under the cursor" by default, and <leader>d belongs to
    -- multiple-cursors. ]d/[d live in core/keymaps.lua so they work in buffers
    -- with no LSP attached too.
    local maps = {
      { 'n', 'K', vim.lsp.buf.hover, 'LSP: Show documentation for what is under cursor' },
      { 'n', 'gd', vim.lsp.buf.definition, 'LSP: Show definition' },
      { 'n', 'gD', vim.lsp.buf.declaration, 'LSP: Go to declaration' },
      -- In visual mode the code action applies to the selection
      { { 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'LSP: Show available code actions' },
      { 'n', '<leader>cr', vim.lsp.buf.rename, 'LSP: Smart rename' },
      { 'n', '<leader>rs', '<cmd>LspRestart<CR>', 'LSP: Restart LSP' },
      { 'n', 'gR', '<cmd>Telescope lsp_references<CR>', 'LSP/Telescope: Show references' },
      { 'n', 'gi', '<cmd>Telescope lsp_implementations<CR>', 'LSP/Telescope: Show implementations' },
      { 'n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', 'LSP/Telescope: Show type definitions' },
      { 'n', '<leader>fd', '<cmd>Telescope diagnostics bufnr=0<CR>', 'LSP/Telescope: Show buffer diagnostics' },
    }

    for _, m in ipairs(maps) do
      local mode, lhs, rhs, desc = unpack(m)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end
  end,
})

-- ======================================================================================
-- File Management

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Return to last edit position when opening files',
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local line = mark[1]
    local ft = vim.bo.filetype
    if line > 0 and line <= lcount and vim.fn.index({ 'commit', 'gitrebase', 'xxd' }, ft) == -1 and not vim.o.diff then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Create directories when saving files
vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Create directories when saving files',
  group = augroup,
  callback = function(ev)
    if not is_real_file_buf(ev.buf) then
      return
    end
    local dir = vim.fn.expand('<afile>:p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

-- ======================================================================================
-- Windows VM over SMB
--
-- MSBuild, IIS and NuGet all still run inside the guest; only editing happens here.
-- Both autocmds below are scoped to the mount so local work keeps the globals set in
-- core/options.lua.
--
-- Nothing here touches line endings or whitespace. Those are normalized identically
-- everywhere: after/ftplugin/{cs,razor}.lua pin 'fileformat' to dos, and the trim on
-- save at the top of this file applies to every buffer regardless of location.
local win_augroup = vim.api.nvim_create_augroup('WindowsVmMount', { clear = true })

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
  desc = 'Windows VM mount: write in place to preserve NTFS ACLs',
  group = win_augroup,
  pattern = win_mount .. '/*',
  callback = function()
    -- The default 'auto' may save by renaming the original aside and writing a new
    -- file in its place, which over SMB leaves the replacement with a default ACL.
    -- That surfaces later as an IIS app-pool permission failure that looks nothing
    -- like an editor problem. 'yes' writes the original file in place instead.
    vim.opt_local.backupcopy = 'yes'
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter' }, {
  desc = 'Windows VM mount: re-check files rewritten inside the guest',
  group = win_augroup,
  callback = function(ev)
    -- SMB delivers no change notifications, so 'autoread' never fires on its own
    -- when a build, a NuGet restore or a source-control operation rewrites files
    -- in the guest. Poll instead, on the events where staleness would be noticed.
    if on_win_mount(ev.buf) and vim.bo[ev.buf].buftype == '' then
      pcall(vim.cmd, 'checktime ' .. ev.buf)
    end
  end,
})

-- ======================================================================================
-- Window Management

-- Auto-resize splits when window is resized
-- vim.api.nvim_create_autocmd('VimResized', {
--   desc = 'Auto-resize splits when window is resized',
--   group = augroup,
--   callback = function()
--     vim.cmd('tabdo wincmd =')
--   end,
-- })

-- ======================================================================================
-- Appearance

-- Purple (mauve) cursor line number in Visual/Visual Block modes, matching the
-- Visual-mode cursor (VisualCursor) and lualine indicator. CursorLineNr has no
-- per-mode variant, so swap it on entering Visual and restore it on leaving.
--
-- Note: CursorLineNr only reaches the line number when 'cursorlineopt' contains
-- "number". This config uses "screenline" (no number highlight in normal mode),
-- so we also add "number" to the window's 'cursorlineopt' while in Visual and
-- restore the original on exit, leaving normal-mode appearance untouched.
local visual_cursorlinenr = '#cba6f7' -- catppuccin mocha mauve
local saved_cursorlinenr
local saved_cursorlineopt -- nil = we did not modify 'cursorlineopt'
vim.api.nvim_create_autocmd('ModeChanged', {
  desc = 'Purple CursorLineNr in Visual modes',
  group = augroup,
  callback = function()
    local in_visual = vim.v.event.new_mode:find('^[vV\22]') ~= nil
    if in_visual then
      -- Capture the colorscheme's real CursorLineNr once, right before the
      -- first override, so the restore below is correct even after a reload.
      saved_cursorlinenr = saved_cursorlinenr or vim.api.nvim_get_hl(0, { name = 'CursorLineNr', link = false })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = visual_cursorlinenr })

      local opt = vim.wo.cursorlineopt
      if saved_cursorlineopt == nil and not opt:find('number') and not opt:find('both') then
        saved_cursorlineopt = opt
        vim.wo.cursorlineopt = opt == '' and 'number' or (opt .. ',number')
      end
    else
      if saved_cursorlinenr then
        vim.api.nvim_set_hl(0, 'CursorLineNr', saved_cursorlinenr)
        saved_cursorlinenr = nil
      end
      if saved_cursorlineopt ~= nil then
        vim.wo.cursorlineopt = saved_cursorlineopt
        saved_cursorlineopt = nil
      end
    end
  end,
})

-- ======================================================================================
-- Adjust wrapping behavior for markdown and text files
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})
