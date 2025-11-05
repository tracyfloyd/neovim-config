local get_intelephense_license = function()
  local f = assert(io.open(os.getenv("HOME") .. "/intelephense/licence.txt", "rb"))
  local content = f:read("*a")
  f:close()
  return string.gsub(content, "%s+", "")
end

---@type vim.lsp.Config
return {
  cmd = { "intelephense", "--stdio" },
  filetypes = {
    "php",
    "blade",
  },
  init_options = {
    licenceKey = get_intelephense_license(),
  },
  settings = {
    intelephense = {
      format = {
        braces = "k&r",
      }
    }
  }
}


