return {
  -- Add a header to neo-tree buffer window
  {
    "rebelot/heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline = { -- statusline
        hl = { fg = "fg", bg = "bg" },
        status.component.mode(),
        status.component.git_branch(),
        status.component.file_info(),
        status.component.git_diff(),
        status.component.diagnostics(),
        status.component.fill(),
        status.component.cmd_info(),
        status.component.fill(),
        status.component.lsp(),
        status.component.virtual_env(),
        status.component.treesitter(),
        status.component.nav(),
      }

      local buffer_matches = require("heirline.conditions").buffer_matches
      local get_icon = require("astroui").get_icon

      local NeoTree = {
        -- cache the static variables
        static = {
          sources = require("astronvim.plugins.neo-tree").opts().sources,
          icons = {
            ["filesystem"] = get_icon("FolderClosed", 0, true),
            ["buffers"] = get_icon("DefaultFile", 0, true),
            ["git_status"] = get_icon("Git", 0, true),
            ["diagnostics"] = get_icon("Diagnostic", 0, true),
          },
          names = {
            ["filesystem"] = "Filesystem",
            ["buffers"] = "Buffers",
            ["git_status"] = "Git Status",
            ["diagnostics"] = "Diagnostic",
          },
          separator = "│",
          segment_width = 5, -- 2 space + get_icon(Icon) + 2 space
        },
        -- determine if the leftmost buffer is NeoTree
        condition = function(self)
          self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
          self.buf = vim.api.nvim_win_get_buf(self.winid)
          return buffer_matches({ filetype = { "neo%-tree" } }, self.buf)
        end,
        -- update if the buffer name has changed, i.e. neo tree source changed
        -- or if the width has changed
        update = function(self)
          local bufname = vim.api.nvim_buf_get_name(self.buf)
          local width = vim.api.nvim_win_get_width(self.winid)
          if (self.bufname ~= bufname) or (self.width ~= width) then
            self.bufname = bufname
            self.width = width
            return true
          end
          return false
        end,
        -- create and init the child components
        init = function(self)
          local children = {}
          for _, source in ipairs(self.sources) do
            -- selene: allow(shadowing)
            local child = {
              init = function(self) ---@diagnostic disable-line:redefined-local
                self.selected = string.match(self.bufname, source)
              end,
              provider = function(self) ---@diagnostic disable-line:redefined-local
                local name = self.selected and (" " .. self.names[source]) or ""
                local icon = self.icons[source]
                local padding, overflow = 2, 0
                if self.selected then
                  -- width of remaining space (total width - width of the text - width of all icons)
                  local spacewidth = (self.width - #name - self.segment_width * #self.sources)
                  -- +1 for the one space by default
                  padding, overflow = (spacewidth / 2) + 2, (spacewidth % 2)
                end
                return string.rep(" ", padding) .. icon .. name .. string.rep(" ", padding + overflow)
              end,
              hl = function(self) ---@diagnostic disable-line:redefined-local
                if self.selected then return { fg = "buffer_active_fg", bg = "buffer_active_bg" } end
                return { fg = "buffer_fg", bg = "buffer_bg" }
              end,
            }
            table.insert(children, child)
          end
          -- selene: allow(shadowing)
          local separator = {
            provider = function(self) ---@diagnostic disable-line:redefined-local
              return self.separator
            end,
            hl = "NeoTreeWinSeparator",
          }
          table.insert(children, separator)
          self[1] = self:new(children, 1)
        end,
      }

      table.remove(opts.tabline, 1)
      table.insert(opts.tabline, 1, NeoTree)
    end,
  },

  -- Remove the source selector winbar from neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      source_selector = {
        winbar = false,
      },
    },
  },
}
