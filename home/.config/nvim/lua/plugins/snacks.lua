-- Keep the file explorer's directories collapsed every time it's opened.
--
-- Note: there's no `folded` config key in snacks.nvim's explorer picker — checked both the
-- installed source and current upstream main, no such option exists anywhere. The real
-- mechanism is `on_show`, a hook the picker calls every time it's displayed; we use it to
-- run the same action already bound to `Z` (explorer_close_all) automatically on every open.

return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            on_show = function(picker)
              require("snacks.explorer.actions").actions.explorer_close_all(picker)
            end,
          },
          files = {
            hidden = false,
            ignored = false,
          },
        },
      },
    },
  },
}
