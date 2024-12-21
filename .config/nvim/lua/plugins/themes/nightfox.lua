return {
  "EdenEast/nightfox.nvim",
  opts = {
    colorblind = {
      enable = true,
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0.5, -- Severity [0,1] for protan (red)
        deutan = 0.2, -- Severity [0,1] for deutan (green)
        tritan = 0, -- Severity [0,1] for tritan (blue)
      },
    },
  },
}
