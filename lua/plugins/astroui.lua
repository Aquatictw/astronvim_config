-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "default",
    highlights = {
      init = { -- this table overrides highlights in all themes
        Normal  = {bg = "NONE"},
        NormalNC  = {bg = "NONE"},
        TabLine = {bg = "NONE"},
        TabLineFill = {bg = "NONE"},

        CursorLine = {bg = "NONE", blend = 40},

        WinBar = {bg = "NONE"},
        WinBarNC = {bg = "NONE"},

      },
    },
    --
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
