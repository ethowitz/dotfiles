return {
  "Mofiqul/dracula.nvim",
  config = function()
    local c = require('dracula').colors()

    require('dracula').setup({
      italic_comment = true,
      overrides = {
        ["@lsp.typemod.method.trait.rust"] = {
          fg = c.fg,
          bg = c.bg,
          bold = true,
        },
        ["@lsp.type.interface.rust"] = {
          fg = c.fg,
          bg = c.bg,
          bold = true,
        },
        ["@lsp.type.lifetime.rust"] = {
          fg = c.yellow,
          bg = c.bg,
        },
        ["@lsp.type.typeParameter.rust"] = {
          fg = c.yellow,
          bg = c.bg,
        }
      }
    })
  end
}
