local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = true,
  sources = {
    -- formatting.prettier.with {
    --   extra_filetypes = { "toml" },
    -- },
    -- formatting.ruff,
    -- formatting.gofumpt,
    -- formatting.goimports_reviser,
    -- formatting.stylua,
    -- diagnostics.flake8.with {
    --   extra_args = {
    --     "--max-line-length=120",
    --     "--ignore=W391",
    --   },
    -- },
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}
