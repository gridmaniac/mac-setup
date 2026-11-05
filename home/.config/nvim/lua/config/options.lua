-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Trying intelephense instead of the lang.php extra's default (phpactor) — phpactor was
-- giving false positives on Eloquent's magic static methods (Model::first(), etc.) and on
-- @mixin-based docblocks in this project's models.
vim.g.lazyvim_php_lsp = "intelephense"
