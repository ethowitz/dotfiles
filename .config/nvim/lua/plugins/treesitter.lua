return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "comment",
        "lua",
        "rust",
        "toml",
        "terraform",
        "python",
        "asm",
        "bash",
        "sql",
        "ruby",
        "typescript",
        "yaml",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
      ident = { enable = true },
    })
  end,
}
