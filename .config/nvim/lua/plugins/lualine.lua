local function mysplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

local function get_harpoon_indicator(harpoon_entry)
  local parts = mysplit(harpoon_entry.value, "/")
  return parts[#parts]
end

local config = {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      theme = "tokyonight-storm",
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
        -- {
        --   "harpoon2",
        --   icon = " ",
        --   color_active = { fg = "#FFFFFF" },
        --   indicators = {
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --   },
        --   active_indicators = {
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --     get_harpoon_indicator,
        --   },
        -- },
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
  },
}

return config
