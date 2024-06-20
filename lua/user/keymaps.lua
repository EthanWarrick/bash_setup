-- Space as leader key
vim.g.mapleader = " "

-- Shortcuts
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>", { desc = "Visual select whole buffer" })
vim.keymap.set("n", "<leader>o", "o<Esc>k", { desc = "Insert newline below" })
vim.keymap.set("n", "<leader>O", "O<Esc>j", { desc = "Insert newline above" })
vim.keymap.set("n", "<c-s>", function()
  vim.cmd.mksession({ bang = true })
  vim.notify("Saved session to Session.vim", vim.log.levels.INFO)
end, { desc = "Save vim session to Session.vim" })

vim.keymap.set("n", "<esc>", function()
  vim.api.nvim_command("fclose")
  vim.api.nvim_command("nohlsearch")
end, { desc = "Close top floating window & disable search highlight" })

-- Essentially creates a line text object
--  - this is for operating on lines without counting the newline
vim.keymap.set({ "x", "o" }, "al", ":normal 0v$h<CR>", { desc = "'around-line' text object" })
vim.keymap.set({ "x", "o" }, "il", ":normal ^vg_<CR>", { desc = "'in-line' text object" })

-- Basic clipboard/register interaction
vim.keymap.set({ "n", "x" }, "gy", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gY", '"+Y', { remap = true, desc = "Copy to system clipboard" })
vim.keymap.set({ "n", "x" }, "gp", '"+p', { desc = "Paste to system clipboard" })
vim.keymap.set("n", "<C-p>", ":let @+ = @%<cr>", { desc = "Copy relative path to system clipboard" })
vim.keymap.set({ "n", "x" }, "x", '"_x', { desc = 'Delete without saving to " register' })

-- Buffer Commands
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>quitall<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Buffer quit" })
vim.keymap.set("n", "<leader>bl", "<cmd>buffer #<cr>", { desc = "Buffer last" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Buffer next" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buffer previous" })

vim.keymap.set("n", "<leader>d", function()
  if vim.diagnostic.is_enabled() then
    vim.diagnostic.enable(false)
  else
    vim.diagnostic.enable(true)
  end
end, { desc = "Toggle diagnostic messages" })

vim.keymap.set({ "n", "x" }, "<F12>", "<cmd>call GenerateCtags()<CR>", { desc = "Generate tags file" })
vim.api.nvim_exec2(
  [[
  " Ctags
  function! s:CtagsHandler(job_id, data, event)
    if a:event == 'exit'
      echo "Generating Tags... Complete"
    endif
  endfunction
  function! GenerateCtags()
    let l:ctags_cmd = "ctags -R --fields=+Slk --c-types=+deftuxgsmp -B --exclude=build --exclude=megainclude ."
    echo "Generating Tags..."
    if has('nvim')
      let job = jobstart(l:ctags_cmd, {'on_exit': function('s:CtagsHandler')})
    else
      call system(l:ctags_cmd)
      call s:CtagsHandler(0, "", 'exit')
    endif
  endfunction
]],
  {}
)

vim.keymap.set("n", "<BS>", ":let @/=expand('<cword>') <bar> set hls <cr>", { silent = true })
