local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
  return
end

ibl.setup {
  indent = {
    char = "|",
  },
  -- show_trailing_blankline_indent = false,
  -- show_first_indent_level = true,
  -- use_treesitter = true,
  -- show_current_context = true,
  exclude = {
    filetypes = {
    "help",
    "packer",
    "NvimTree",
    },
    buftypes = { "terminal", "nofile" },
  },
}
