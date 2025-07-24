-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
      },
      timeout_ms = 500, -- default format timeout
    },
    -- customize language server configuration options passed to `lspconfig`
    ---@diagnostic disable: missing-fields
    config = {

      pyright = { 
        settings = {
          python = {
            analysis = {
              -- typeCheckingMode = "basic", 
              -- diagnosticSeverityOverrides = {
              --    reportOptionalMemberAccess = "information",
              --    reportArgumentType = "warning",
                -- }
            }
          }
        }
      }

      -- clangd = { capabilities = { offsetEncoding = "utf-8" } },
    },
  },
}
