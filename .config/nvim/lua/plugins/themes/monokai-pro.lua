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
    },
    override = function(c)
      return {
        -- snacks.nvim highlights
        SnacksPicker = {
          bg = c.editor.background,
        },
        SnacksPickerDir = {
          fg = c.base.dimmed3,
        },

        -- Rust highlights
        ["@lsp.typemod.function.trait.rust"] = {
          bold = true,
        },
        ["@lsp.typemod.method.trait.rust"] = {
          bold = true,
        },
        ["@lsp.type.interface.rust"] = {
          bold = true,
        },
        ["@lsp.type.lifetime.rust"] = {
          fg = c.yellow,
        },
        -- ["@lsp.type.typeParameter.rust"] = {
        --   fg = c.yellow,
        --   bg = c.bg,
        -- },
      }
    end,
  },
}
