return {
  "nanozuki/tabby.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("tabby").setup({
      line = function(line)
        return {
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and "TabLineSel" or "TabLine"
            return {
              line.sep("", hl, "TabLineFill"),
              tab.name(),
              line.sep("", hl, "TabLineFill"),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
        }
      end,
    })
  end,
}
