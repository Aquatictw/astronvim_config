return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      -- having these both false just show normal file path in neo-tree
      winbar = false, -- toggle to show selector on winbar
      statusline = false,
      sources = {
        -- Comment back in if you want sources later
        -- { source = "filesystem" },
        -- { source = "buffers" },
        -- { source = "git_status" },
      },
    },
  },
}
