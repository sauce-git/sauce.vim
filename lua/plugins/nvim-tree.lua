vim.pack.add({
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons.git",
    name = "nvim-web-devicons",
  },
  {
    src = "https://github.com/nvim-tree/nvim-tree.lua.git",
    name = "nvim-tree.lua",
  },
})

vim.defer_fn(function()
  local ok, nvim_tree = pcall(require, "nvim-tree")
  if not ok then
    vim.notify("nvim-tree not found", vim.log.levels.ERROR)
    return
  end

  nvim_tree.setup({
    sort_by = "case_sensitive",
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      group_empty = false,
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      },
    },
    filters = {
      dotfiles = false,
    },
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    git = {
      enable = true,
      ignore = false,
    },
  })

  vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<cr>")

  print("nvim-tree loaded")
end, 0)
