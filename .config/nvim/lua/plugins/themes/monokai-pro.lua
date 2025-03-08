return {
  "loctvl842/monokai-pro.nvim",
  opts = {
    filter = "octagon",
    styles = {
      comment = { italic = true },
      keyword = { italic = true }, -- any other keyword
      type = { italic = false }, -- (preferred) int, long, char, etc
      storageclass = { italic = false }, -- static, register, volatile, etc
      structure = { italic = false }, -- struct, union, enum, etc
      parameter = { italic = false }, -- parameter pass in function
      annotation = { italic = false },
      tag_attribute = { italic = false },
      builtin = { italic = false },
    },
    override = function(c)
      local orange = "#FF9B5E"

      return {
        -- snacks.nvim highlights
        SnacksPicker = {
          bg = c.editor.background,
        },
        SnacksPickerDir = {
          fg = c.base.dimmed3,
        },

        -- General highlights
        ["@type.builtin"] = {
          italic = false,
        },
        ["@variable.builtin"] = {
          italic = false,
        },
        ["@variable.parameter"] = {
          italic = false,
        },
        ["@module"] = {
          fg = c.editor.foreground,
        },
        ["@function.macro"] = {
          fg = c.base.magenta,
        },
        ["@punctuation.bracket"] = {
          fg = c.base.dimmed3,
        },

        -- Rust highlights
        ["@keyword.function.rust"] = {
          fg = c.base.red,
        },
        ["@lsp.typemod.function.trait.rust"] = {
          bold = true,
          fg = c.base.cyan,
        },
        ["@lsp.typemod.method.trait.rust"] = {
          bold = true,
          fg = c.base.cyan,
        },
        ["@lsp.type.interface.rust"] = {
          bold = true,
          fg = c.base.cyan,
        },
        ["@lsp.type.lifetime.rust"] = {
          fg = c.base.magenta,
        },
        ["@lsp.type.typeParameter.rust"] = {
          fg = c.base.magenta,
        },
        ["@lsp.type.parameter.rust"] = {
          fg = orange,
        },
        ["@lsp.typemod.macro.defaultLibrary.rust"] = {
          fg = c.base.magenta,
        },
        ["@keyword.type.rust"] = {
          fg = c.base.red,
        },
      }
    end,
  },
}
