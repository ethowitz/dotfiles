return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require("lualine").setup({
      options = {
        -- theme = "monokai-pro",
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filetype",
            colored = true,
            icon_only = true,
          },
          {
            "filename",
            path = 1,
            padding = { left = 0 },
            symbols = {
              modified = " ", -- Text to show when the file is modified.
              readonly = " ", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "",
              newfile = " ", -- Text to show for newly created file before first write
            },
          },
        },
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = "  ", warn = "  ", info = "󰋼 ", hint = "󰌵 " },
            colored = true,
            update_in_insert = false,
            padding = { right = 0 },
          },
          {
            "location",
            padding_left = 0,
          },
        },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
