return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      dim_inactive = true,
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        -- Background styles. Can be "dark", "transparent" or "normal"
        -- sidebars = "transparent", -- style for sidebars, see below
        floats = "dark", -- style for floating windows
      },
      day_brightness = 0.1,
      on_highlights = function(hl, c)
        -- hl["@lsp.typemod.variable.mutable.rust"] = {
        --   fg = c.fg,
        --   bg = c.bg,
        --   underline = true,
        -- }
        hl["@lsp.typemod.function.trait.rust"] = {
          fg = c.fg,
          bg = c.bg,
          bold = true,
        }
        hl["@lsp.typemod.method.trait.rust"] = {
          fg = c.fg,
          bg = c.bg,
          bold = true,
        }
        hl["@lsp.type.interface.rust"] = {
          fg = c.fg,
          bg = c.bg,
          bold = true,
        }
        hl["@lsp.type.lifetime.rust"] = {
          fg = c.yellow,
          bg = c.bg,
        }
        hl["@lsp.type.typeParameter.rust"] = {
          fg = c.yellow,
          bg = c.bg,
        }
      end,
    },
  },
}
