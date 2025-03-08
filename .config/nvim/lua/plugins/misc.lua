return {
  ------------------------------------ UI -------------------------------------
  "kyazdani42/nvim-web-devicons",
  ----------------------------- MOVEMENT AND SYNTAX --------------------------
  "tpope/vim-sleuth", -- automatically set 'shiftwidth' and 'expandtab'
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = {
        "TelescopePrompt",
        "spectre_panel",
        "snacks_input",
        "snacks_picker_input",
      },
    },
  },
}
