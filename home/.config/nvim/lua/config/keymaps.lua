-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>cy", function()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  local text = string.format("%s:%d", file, line)

  vim.fn.setreg("+", text)
  print("Copied: " .. text)
end, { desc = "Copy file:line" })
