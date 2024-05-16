---@type LazyPluginSpec
local Plugin = { "kyazdani42/nvim-tree.lua" }

Plugin.cmd = { "NvimTreeToggle" }

Plugin.keys = {
  { "<leader>e", "<cmd>NvimTreeToggle<cr>", mode = "n", desc = "Open file tree" },
}

-- See :help nvim-tree-setup
Plugin.opts = {
  hijack_cursor = true,
  on_attach = function(bufnr)
    local bufmap = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc })
    end

    -- :help nvim-tree.api
    local api = require("nvim-tree.api")

    bufmap("L", api.node.open.edit, "Expand folder or go to file")
    bufmap("H", api.node.navigate.parent_close, "Close parent folder")
    bufmap("gh", api.tree.toggle_hidden_filter, "Toggle hidden files")

    -- This opens a file then moves the cursor back to the file explorer window
    bufmap("<cr>", function()
      api.node.open.edit() -- Call the nvim-tree edit api call (see nvim-tree docs)
      vim.cmd("wincmd t") -- Call vimscript goto previous window
    end, "Expand folder or open file")
  end,
}

return Plugin
