vim.pack.add({
  {
    src = "https://github.com/nvim-tree/nvim-web-devicons.git",
    name = "nvim-web-devicons",
  },
  {
    src = "https://github.com/nvimdev/dashboard-nvim.git",
    name = "dashboard-nvim",
  },
})

local ok, dashboard = pcall(require, "dashboard")
if not ok then
  vim.notify("dashboard-nvim not found", vim.log.levels.ERROR)
  return
end

dashboard.setup({
  theme = "hyper",
  config = {
    header = {
      "",
      "███████╗ █████╗ ██╗   ██╗ ██████╗███████╗",
      "██╔════╝██╔══██╗██║   ██║██╔════╝██╔════╝",
      "███████╗███████║██║   ██║██║     █████╗  ",
      "╚════██║██╔══██║██║   ██║██║     ██╔══╝  ",
      "███████║██║  ██║╚██████╔╝╚██████╗███████╗",
      "╚══════╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚══════╝",
      "",
    },
    weak_header = {
      enable = true,
    },
    shortcut = {
      {
        desc = "Find File",
        group = "Label",
        action = "FzfLua files",
        key = "f",
      },
      {
        desc = "Find Word",
        group = "Label",
        action = "FzfLua live_grep",
        key = "w",
      },
      {
        desc = "Nvim Tree",
        group = "Label",
        action = "NvimTreeToggle",
        key = "e",
      },
      {
        desc = "Quit",
        group = "Label",
        action = "qa",
        key = "q",
      },
    },
    packages = { enable = false },
    project = { enable = true, limit = 8, icon = "📁  ", label = "Projects", action = "FzfLua files cwd=" },
    mru = { enable = false, limit = 10, icon = "", label = "", cwd_only = false },
    footer = {
      "Hard Work & Dedication",
    },
  },
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- if vim.fn.argc() == 0 then
    --   vim.cmd("Dashboard")
    -- end
    local arg = vim.fn.argv(0)
    if vim.fn.isdirectory(arg) == 1 then
      vim.cmd("cd " .. arg)
      vim.cmd("Dashboard")
    end
  end,
})

print("dashboard-nvim loaded")
