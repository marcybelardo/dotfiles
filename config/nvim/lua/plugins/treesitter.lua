return {
    {
        "nvim-treesitter/nvim-treesitter",
        version = false,
        build = ":TSUpdate",
        event = "VeryLazy",
        lazy = vim.fn.argc(-1) == 0,
        cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
        opts_extend = { "ensure_installed" },
        ---@type TSConfig
        ---@diagnostic disable-next-line: missing-fields
        opts = {
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            ensure_installed = {
                "c",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "rust",
                "python",
                "elixir"
            },
            sync_install = false,
            auto_install = true,
        },
        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
