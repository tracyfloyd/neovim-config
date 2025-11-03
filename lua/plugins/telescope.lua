-- Telescope
--
-- @link https://github.com/nvim-telescope/telescope.nvim

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            local telescope = require("telescope")
            local actions = require("telescope.actions")

            telescope.setup({
                pickers = {
                    buffers = {
                        mappings = {
                            i = { -- Insert mode
                                ["<C-d>"] = actions.delete_buffer + actions.move_to_top, -- Remove an item from the buffer list
                                ["<C-k>"] = actions.move_selection_previous, -- Move to previous result
                                ["<C-j>"] = actions.move_selection_next, -- Move to next result
                                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                            },
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            local keymap = vim.keymap

            keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope - Fuzzy find files in cwd" })

            keymap.set("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Telescope - Fuzzy find recent files" })

            keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Telescope - Show previous search state" })

            keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Telescope - Find string in cwd" })
            keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Telescope - Find string under cursor in cwd" })
            keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Telescope - Find todos" })

            keymap.set("n", "<leader>fd", "<cmd>Telescope lsp_document_diagnostics<cr>", { desc = "Telescope - Document diagnostics" })
            keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Telescope - Buffer file name search" })
            keymap.set("n", "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Telescope - Current buffer fuzzy search" })

            keymap.set("n", "<C-p>",      "<cmd>Telescope git_files<cr>", { desc = "Telescope - Git files" })

            keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Telescope - Help" })
            keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Telescope - Keymaps" })

            keymap.set("n", "<leader>fl", "<cmd>Telescope lsp_references<cr>", { desc = "Telescope - Lsp References" })
            --keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Telescope - Treesitter" })

            keymap.set("n", "<leader>fn", function()
                require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
            end, { desc = "Telescope - Find in Neovim config" })

        end,

    },
}
