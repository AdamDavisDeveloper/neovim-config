require("adam.plugins-setup")
require("adam.core.options")
require("adam.core.keymaps")
require("adam.core.colorscheme")
require("adam.plugins.comment")
require("adam.plugins.nvim-tree")
require("adam.plugins.lualine")
require("adam.plugins.telescope")
require("adam.plugins.nvim-cmp")
require("adam.plugins.autopairs")
require("adam.plugins.treesitter")
require("adam.plugins.luasnip")
require("adam.plugins.dashboard")
vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nvimtree",
  callback = function()
    vim.cmd [[
      hi Normal guibg=NONE ctermbg=NONE
      hi NormalNC guibg=NONE ctermbg=NONE
    ]]
  end,
})
