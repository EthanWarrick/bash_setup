-- Space as leader key
vim.g.mapleader = " "

local close_floats = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= "" then -- is_floating_window?
      vim.api.nvim_win_close(win, false) -- do not force
    end
  end
end
vim.keymap.set("n", "<esc>", function()
  close_floats()
  vim.api.nvim_command("nohlsearch")
end, { desc = "Close all floating windows & disable search highlight" })

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
