return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local theme = require("monokai-pro.colorscheme")
    local c = theme.get("octagon")
    local colors = {
      blue = c.base.blue,
      cyan = c.base.cyan,
      black = c.base.black,
      white = c.base.dimmed1,
      red = c.base.red,
      violet = c.base.magenta,
      grey = "#212430",
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.violet },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.grey },
      },

      insert = { a = { fg = colors.black, bg = colors.blue } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },

      inactive = {
        a = { fg = c.base.dimmed3, bg = colors.grey },
        b = { fg = c.base.dimmed3, bg = colors.grey },
        c = { fg = c.base.dimmed3, bg = colors.grey },
      },
    }

    require("lualine").setup({
      options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            function()
              return " "
            end,
            padding = { left = 0, right = 0 },
          },
        },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
          },
          {
            "filename",
            path = 1,
            shorting_target = 100,
            symbols = {
              modified = "",
              readonly = "",
              unnamed = "",
              newfile = "",
            },
            padding = { left = 0, right = 1 },
          },
        },
        lualine_c = {
          "%=", --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = {
          {
            "diagnostics",
            sources = { "nvim_workspace_diagnostic" },
            sections = { "error", "warn" },
            symbols = { error = "  ", warn = "  ", info = "󰋼 ", hint = "󰌵 " },
            colored = true,
            update_in_insert = false,
            padding = { right = 1, left = 1 },
          },
          "progress",
          "location",
        },
        lualine_z = {
          {
            function()
              return " "
            end,
            padding = { left = 0, right = 0 },
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      tabline = {},
      extensions = {},
    })
  end,
}
