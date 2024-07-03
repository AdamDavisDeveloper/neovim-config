local status, _ = pcall(vim.cmd, "colorscheme nordic")
if not status then
  print("Colorscheme not found!")
  return
end

-- Set background transparency
vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
vim.cmd("highlight NonText guibg=NONE ctermbg=NONE")
