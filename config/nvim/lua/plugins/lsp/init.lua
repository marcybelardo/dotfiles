return {
    {
        "mason-org/mason.nvim",
        tag = "v1.11.0",
        pin = true,
        lazy = false,
        opts = {},
    },

    {
        "mason-org/mason-lspconfig.nvim",
        tag = "v1.32.0",
        pin = true,
        lazy = true,
        config = false,
    },

    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
    },

    -- autocomplete
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                preselect = "item",
                completion = {
                    completeopt = "menu,menuone,noinsert"
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- simple tab complete
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        local col = vim.fn.col('.') - 1

                        if cmp.visible() then
                            cmp.select_next_item({behavior = 'select'})
                        elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                            fallback()
                        else
                            cmp.complete()
                        end
                    end, {'i', 's'}),
                    -- go to previous item
                    ['<S-Tab>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                    -- jump to next snippet placeholder
                    ['<C-f>'] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")
                        if luasnip.locally_jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    -- jump to the previous snippet placeholder
                    ['<C-b>'] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")
                        if luasnip.locally_jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                }),
            })
        end
    },

    {
        "saadparwaiz1/cmp_luasnip"
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        tag = "v1.8.0",
        pin = true,
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "mason-org/mason.nvim" },
            { "mason-org/mason-lspconfig.nvim" },
        },
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config

            -- add cmp_nvim_lsp capabilities settings to lspconfig
            -- should be executed before configuring language servers
            lsp_defaults.capabilities = vim.tbl_deep_extend(
                "force",
                lsp_defaults.capabilities,
                require("cmp_nvim_lsp").default_capabilities()
            )

            -- LspAttach is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "lua_ls",
                    "rust_analyzer",
                    "basedpyright",
                    "elixirls",
                },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every lang server without a custom handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({})
                    end,

                    elixirls = function()
                        require("lspconfig").elixirls.setup({
                            cmd = { "/usr/share/elixir-ls/language_server.sh" },
                        })
                    end,

                    emmet_ls = function()
                        require("lspconfig").emmet_ls.setup({
                            filetypes = {
                                "css",
                                "eruby",
                                "html",
                                "javascript",
                                "javascriptreact",
                                "less",
                                "sass",
                                "scss",
                                "svelte",
                                "pug",
                                "typescriptreact",
                                "vue"
                            },
                            init_options = {
                                html = {
                                    options = {
                                        ["bem.enabled"] = true,
                                    },
                                },
                            },
                        })
                    end,
                }
            })
        end
    },

    {
        "folke/trouble.nvim",
        opts = {
            modes = {
                test = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
            },
        },
        cmd = "Trouble",
        keys = {
            { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },
}
