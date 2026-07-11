-- ============================================================
-- AI Tools Integration (OpenCode, Claude Code)
-- ============================================================

local M = {}

-- Helper: Find window by buffer name
local function get_win(buf_name)
  local buf = vim.fn.bufnr(buf_name)
  if buf == -1 then
    return nil
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end
  return nil
end

-- Helper: Get buffer ID by name
local function get_buf(buf_name)
  return vim.fn.bufnr(buf_name)
end

-- Helper: Open vertical split with specific buffer
local function open_split_with_buf(buf)
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("vertical resize 80")
  vim.api.nvim_win_set_buf(0, buf)
  vim.cmd("startinsert")
end

-- Helper: Open terminal in split with specific name and command
local function open_terminal(buf_name, cmd)
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("vertical resize 80")
  vim.cmd("terminal " .. cmd)
  vim.api.nvim_buf_set_name(0, buf_name)
  vim.cmd("startinsert")
end

-- ============================================================
-- Tool Definitions
-- ============================================================

local tools = {
  {
    name = "OpenCode",
    buf_name = "opencode://terminal",
    cmd = "opencode",
  },
  {
    name = "Claude Code",
    buf_name = "claude://terminal",
    cmd = "claude",
  },
}

-- ============================================================
-- Main Logic
-- ============================================================

local function is_terminal_active(buf)
  if buf == -1 then
    return false
  end
  local chan = vim.api.nvim_buf_get_var(buf, "terminal_job_id")
  if not chan then
    return false
  end
  return vim.fn.jobpid(chan) ~= 0
end

local function handle_tool(tool)
  local win = get_win(tool.buf_name)

  if win then
    vim.api.nvim_win_close(win, true)
    return
  end

  local buf = get_buf(tool.buf_name)
  if buf ~= -1 and is_terminal_active(buf) then
    open_split_with_buf(buf)
    return
  end

  if buf ~= -1 then
    vim.api.nvim_buf_delete(buf, { force = true })
  end

  if tool.start then
    tool.start()
  else
    open_terminal(tool.buf_name, tool.cmd)
  end
end

local last_tool = nil

local function ai_toggle()
  if vim.api.nvim_get_mode().mode == "t" then
    vim.cmd("stopinsert")
  end

  for _, tool in ipairs(tools) do
    if get_win(tool.buf_name) then
      last_tool = tool
      vim.api.nvim_win_close(get_win(tool.buf_name), true)
      return
    end
  end

  if last_tool then
    handle_tool(last_tool)
    return
  end

  vim.ui.select(tools, {
    prompt = "Select AI Tool:",
    format_item = function(t)
      return t.name
    end,
  }, function(choice)
    if choice then
      last_tool = choice
      handle_tool(choice)
    end
  end)
end

local function ai_select()
  if vim.api.nvim_get_mode().mode == "t" then
    vim.cmd("stopinsert")
  end

  vim.ui.select(tools, {
    prompt = "Select AI Tool:",
    format_item = function(t)
      return t.name
    end,
  }, function(choice)
    if choice then
      last_tool = choice
      handle_tool(choice)
    end
  end)
end

vim.keymap.set({ "n" }, "<leader>ai", ai_toggle, { desc = "Toggle AI Tool" })
vim.keymap.set({ "n" }, "<leader>aI", ai_select, { desc = "Select AI Tool" })
