local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities()

M.setup = function()
  -- Configure diagnostics with custom signs
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.HINT]  = "",
        [vim.diagnostic.severity.INFO]  = "",
      },
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticSignWarn",
        [vim.diagnostic.severity.HINT]  = "DiagnosticSignHint",
        [vim.diagnostic.severity.INFO]  = "DiagnosticSignInfo",
      },
    },
    virtual_text = false, -- disable virtual text
    signs = {
      active = signs, -- show signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })


  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>Mason<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

local function python_keymaps(bufnr)
  local opts = { noremap = true, silent = true, desc = "butts" }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "<leader>tt", "<cmd>lua require('dap-python').test_method()<cr>", opts) -- runs in debug mode by default
  keymap(bufnr, "n", "<leader>td", "<cmd>lua require('dap-python').test_method()<cr>", opts) -- runs in debug mode by default
  -- Currently no run_file command. That would be a cool contribution.
end

local function typescript_keymaps(bufnr)
  local opts = { noremap = true, silent = true, desc = "TS butts" }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "<leader>tt", "<cmd>lua require('jester').run()<cr>", opts)
  keymap(bufnr, "n", "<leader>td", "<cmd>lua require('jester').debug()<cr>", opts)
  keymap(bufnr, "n", "<leader>tD", "<cmd>lua require('jester').debug_last()<cr>", opts)
  keymap(bufnr, "n", "<leader>tf", "<cmd>lua require('jester').run_file()<cr>", opts)
  keymap(bufnr, "n", "<leader>tF", "<cmd>lua require('jester').debug_file()<cr>", opts)
  keymap(bufnr, "n", "<leader>tl", "<cmd>lua require('jester').run_last()<cr>", opts)
end

M.on_attach = function(client, bufnr)
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    typescript_keymaps(bufnr)
  end

  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
  end

  if client.name == "pyright" then
    python_keymaps(bufnr)
  end

  if client.name == "clangd" then
    client.offset_encoding = "utf-8"
    local notify = vim.notify
    vim.notify = function(msg, ...)
      if msg:match "warning: multiple different client offset_encodings" then
        return
      end
      notify(msg, ...)
    end
  end

  lsp_keymaps(bufnr)
  local status_ok, illuminate = pcall(require, "illuminate")
  if not status_ok then
    return
  end
  illuminate.on_attach(client)
end

M.settings = function(client, _)
  if client.name == "gopls" then
    return {
      gopls =
    {
      completeUnimported = true,
      usePlaceholders = true,
    }}
  end
  return {}
end

M.get_server_name = function(client, _)
  if client.name == "pyright" then
    return true
  end
end

return M
