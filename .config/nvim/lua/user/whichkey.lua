local cool, wk = pcall(require, "which-key")
if not cool then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  -- key_labels = {
  --   -- override the label used to display some keys. It doesn't effect WK in any other way.
  --   -- For example:
  --   -- ["<space>"] = "SPC",
  --   ["<leader>"] = "SPC",
  --   -- ["<cr>"] = "RET",
  --   -- ["<tab>"] = "TAB",
  -- },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  -- popup_mappings = {
  --   scroll_down = "<c-d>", -- binding to scroll down inside the popup
  --   scroll_up = "<c-u>", -- binding to scroll up inside the popup
  -- },
  -- window = {
  --   border = "rounded", -- none, single, double, shadow
  --   position = "bottom", -- bottom, top
  --   margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
  --   padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  --   winblend = 0,
  -- },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
  -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = false, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  -- triggers_blacklist = {
  --   -- list of mode / prefixes that should never be hooked by WhichKey
  --   -- this is mostly relevant for key maps that start with a native binding
  --   -- most people should not need to change this
  --   i = { "j", "k" },
  --   v = { "j", "k" },
  -- },
}

wk.setup(setup)
wk.add({

  -- Visual mode leader
  { "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', desc = "Comment", mode = "v"},
  { "<leader>s", "<esc><cmd>'<,'>SnipRun<cr>", desc = "Run Range", mode = "v"},
  { "<leader>y", "ygv<ESC>", desc = "Yank n stay", mode = "v" },
  { "<leader>g", "<cmd>GBrowse<CR>", desc = "Github", mode = "v" },

  -- Root leader menu
  
  { "<leader>y", "ggVGy", desc = "Yank File", nowait = true, remap = false},
  { "<leader>/", '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', desc = "Comment"},
  { "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Action"},
  { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer" },
  { "<leader>v", "<cmd>vsplit<cr>", desc = "vsplit" },
  { "<leader>h", "<cmd>split<cr>", desc = "split" },
  { "<leader>w", "<cmd>w<CR>", desc = "Write" },
  { "<leader>.", "<cmd>set invrelativenumber!<CR>", desc = "Toggle Relative Numbers" },
  { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer" },
  { "<leader>n", "<cmd>nohlsearch<CR>", desc = "No HL" },
  { "<leader>o", "<cmd>only<CR>", desc = "Only"},

  -- p: Packer
  { "<leader>p", group = "Packer"},
  { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = true, remap = false},
  { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = true, remap = false },
  { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = true, remap = false },
  { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = true, remap = false },
  { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = true, remap = false },

  -- d: Debug
  { "<leader>d", group = "Debug" },
  { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Breakpoint", nowait = true, remap = false },
  { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
  { "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", desc = "Into", nowait = true, remap = false },
  { "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", desc = "Over", nowait = true, remap = false },
  { "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", desc = "Out", nowait = true, remap = false },
  { "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", desc = "Repl", nowait = true, remap = false },
  { "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", desc = "Last", nowait = true, remap = false },
  { "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", desc = "UI", nowait = true, remap = false },
  { "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", desc = "Exit", nowait = true, remap = false },

  -- f: Find
  { "<leader>f", group = "Find" },
  { "<leader>fb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>fc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files", nowait = true, remap = false },
  { "<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Find Text", nowait = true, remap = false },
  { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find String", nowait = true, remap = false },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help", nowait = true, remap = false },
  { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlights", nowait = true, remap = false },
  { "<leader>fi", "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", desc = "Media", nowait = true, remap = false },
  { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search", nowait = true, remap = false },
  { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File", nowait = true, remap = false },
  { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
  { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },

  -- g: Git
  { "<leader>g", group = "Git" },
  { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = true, remap = false },
  { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
  { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
  { "<leader>gl", "<cmd>Gitsigns blame_line<cr>", desc = "Blame", nowait = true, remap = false },
  { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
  { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
  { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
  { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
  { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
  { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
  { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
  { "<leader>gd", "<cmd>Gvdiffsplit!<cr>", desc = "Diff", nowait = true, remap = false },
  { "<leader>g[", "<cmd>diffget //2<cr>", desc = "Pull from left", nowait = true, remap = false },
  { "<leader>g]", "<cmd>diffget //3<cr>", desc = "Pull from right", nowait = true, remap = false },
  { "<leader>gh", "<cmd>GBrowse<cr>", desc = "Github", nowait = true, remap = false },

  -- l: LSP
  { "<leader>l", group = "LSP" },
  { "<leader>lw", "<cmd>Telescope lsp_workspace_diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
  { "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>lh", "<cmd>lua require('lsp-inlayhints').toggle()<cr>", desc = "Toggle Hints", nowait = true, remap = false },
  { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
  { "<leader>lu", "<cmd>LuaSnipUnlinkCurrent<cr>", desc = "Unlink Snippet", nowait = true, remap = false },

  -- t: Test
  { "<leader>t", group = "Test" },
  { "<leader>tt", nil, desc = "Test Current Func/Method", nowait = true, remap = false },
  { "<leader>td", nil, desc = "Debug Current Func/Method", nowait = true, remap = false },
  { "<leader>tf", nil, desc = "Test File (Node)", nowait = true, remap = false },
  { "<leader>tD", nil, desc = "Debug Last (Node)", nowait = true, remap = false },
  { "<leader>tF", nil, desc = "Debug File (Node)", nowait = true, remap = false },
  { "<leader>tl", nil, desc = "Run Last (Node)", nowait = true, remap = false },
  
  -- s: Snippits
  { "<leader>s", group = "Snippets", nowait = true, remap = false },
  { "<leader>si", "<cmd>:r ~/.config/nvim/snippits/c/stdio.c<cr>", desc = "stdio", nowait = true, remap = false },

})
-- local opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "<leader>",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }

-- local m_opts = {
--   mode = "n", -- NORMAL mode
--   prefix = "m",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }

-- local m_mappings = {
--   a = { "<cmd>silent BookmarkAnnotate<cr>", "Annotate" },
--   c = { "<cmd>silent BookmarkClear<cr>", "Clear" },
--   b = { "<cmd>silent BookmarkToggle<cr>", "Toggle" },
--   m = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
--   ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
--   [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
--   l = { "<cmd>lua require('user.bfs').open()<cr>", "Buffers" },
--   j = { "<cmd>silent BookmarkNext<cr>", "Next" },
--   s = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
--   k = { "<cmd>silent BookmarkPrev<cr>", "Prev" },
--   S = { "<cmd>silent BookmarkShowAll<cr>", "Prev" },
--   -- s = {
--   --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
--   --   "Show",
--   -- },
--   x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
--   [";"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
-- }

-- local mappings = {
  -- ["1"] = "which_key_ignore",
  -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Action" },
  -- b = { "<cmd>Telescope buffers<cr>", "Buffers" },
  -- e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  -- v = { "<cmd>vsplit<cr>", "vsplit" },
  -- h = { "<cmd>split<cr>", "split" },
  -- w = { "<cmd>w<CR>", "Write" },
  -- y = { "ggVGy", "Yank File"},
  -- ["/"] = { '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', "Comment" },
  -- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  -- toggle relative line numbers with .
  -- ["."] = { "<cmd>set invrelativenumber!<CR>", "Toggle Relative Numbers" },
  -- c = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  -- n = { "<cmd>nohlsearch<CR>", "No HL" },
  -- ["gy"] = "Link",

  -- p = {
  --   name = "Packer",
  --   c = { "<cmd>PackerCompile<cr>", "Compile" },
  --   i = { "<cmd>PackerInstall<cr>", "Install" },
  --   s = { "<cmd>PackerSync<cr>", "Sync" },
  --   S = { "<cmd>PackerStatus<cr>", "Status" },
  --   u = { "<cmd>PackerUpdate<cr>", "Update" },
  -- },

  -- o = { "<cmd>only<cr>", "Only"},

  -- d = {
  --   name = "Debug",
  --   b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
  --   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
  --   i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
  --   o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
  --   O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
  --   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
  --   l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
  --   u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
  --   x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
  -- },
  --
  -- f = {
  --   name = "Find",
  --   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  --   c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
  --   f = { "<cmd>Telescope find_files<cr>", "Find files" },
  --   t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  --   s = { "<cmd>Telescope grep_string<cr>", "Find String" },
  --   h = { "<cmd>Telescope help_tags<cr>", "Help" },
  --   H = { "<cmd>Telescope highlights<cr>", "Highlights" },
  --   i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
  --   l = { "<cmd>Telescope resume<cr>", "Last Search" },
  --   M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
  --   r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
  --   R = { "<cmd>Telescope registers<cr>", "Registers" },
  --   k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  --   C = { "<cmd>Telescope commands<cr>", "Commands" },
  -- },
  --
  -- g = {
  --   name = "Git",
  --   g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
  --   j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
  --   k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
  --   l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
  --   p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
  --   r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
  --   R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
  --   s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
  --   u = {
  --     "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
  --     "Undo Stage Hunk",
  --   },
  --   o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
  --   b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
  --   c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
  --   d = {
  --     "<cmd>Gvdiffsplit!<cr>",
  --     "Diff",
  --   },
  --   ["["] = {"<cmd>diffget //2<cr>", "Pull from left"},
  --   ["]"] = {"<cmd>diffget //3<cr>", "Pull from right"},
  --   h = { "<cmd>GBrowse<cr>", "Github" }
  -- },
  --
  -- l = {
  --   name = "LSP",
  --   w = {
  --     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
  --     "Workspace Diagnostics",
  --   },
  --   f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
  --   i = { "<cmd>LspInfo<cr>", "Info" },
  --   h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle Hints" },
  --   I = { "<cmd>LspInstallInfo<cr>", "Mason Info" },
  --   j = {
  --     "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
  --     "Next Diagnostic",
  --   },
  --   k = {
  --     "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
  --     "Prev Diagnostic",
  --   },
  --   l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
  --   q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
  --   r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  --   s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  --   S = {
  --     "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
  --     "Workspace Symbols",
  --   },
  --   u = { "<cmd>LuaSnipUnlinkCurrent<cr>", "Unlink Snippet" },
  -- },
  --
  -- t = {
  --   name = "Test",
  --   t = { nil, "Test Current Func/Method" },
  --   d = { nil, "Debug Curent Func/Method" },
  --   f = { nil, "Test File (Node)" },
  --   D = { nil, "Debug Last (Node)" },
  --   F = { nil, "Debug File (Node)" },
  --   l = { nil, "Run Last (Node)" },
  -- },
  --
  -- s = {
  --   name = "Snippets",
  --   i = { "<cmd>:r ~/.config/nvim/snippits/c/stdio.c<cr>", "stdio" },
  -- },
-- }

-- local vopts = {
--   mode = "v", -- VISUAL mode
--   prefix = "<leader>",
--   buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
--   silent = true, -- use `silent` when creating keymaps
--   noremap = true, -- use `noremap` when creating keymaps
--   nowait = true, -- use `nowait` when creating keymaps
-- }
-- local vmappings = {
--   ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', "Comment" },
--   s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
--   y = { "ygv<ESC>", "Yank n stay" },
--   g = {":GBrowse<cr>", "Github"}
--   -- z = { "<cmd>TZNarrow<cr>", "Narrow" },
-- }
-- wk.register(mappings, opts)
-- wk.register(vmappings, vopts)
-- wk.register(m_mappings, m_opts)

