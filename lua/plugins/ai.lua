-- ============================================================
-- AI Tools Integration (Aider, OpenCode, Claude Code)
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
-- Aider Specific Logic
-- ============================================================

local aider_providers = {
  {
    name = "OpenRouter",
    prefix = "openrouter/",
    list_cmd = { "aider", "--list-models", "openrouter/" },
  },
  -- Add more providers here if needed
}

local function select_aider_model(provider)
  vim.notify("Loading models... (" .. provider.name .. ")", vim.log.levels.INFO)

  vim.system(
    provider.list_cmd,
    { text = true },
    function(result)
      vim.schedule(function()
        if result.code ~= 0 or not result.stdout then
          vim.notify(provider.name .. ": failed to load models", vim.log.levels.ERROR)
          return
        end

        local models = {}
        for line in result.stdout:gmatch("[^\n]+") do
          local model = line:match("^%s*-%s*(" .. vim.pesc(provider.prefix) .. ".+)%s*$")
          if model then
            table.insert(models, model)
          end
        end

        if #models == 0 then
          vim.notify(provider.name .. ": no models found", vim.log.levels.WARN)
          return
        end

        vim.ui.select(models, {
          prompt = "Select " .. provider.name .. " model:",
          format_item = function(item)
            return item:gsub(vim.pesc(provider.prefix), "")
          end,
        }, function(choice)
          if choice then
            open_terminal("aider://terminal", "aider --model " .. choice)
          end
        end)
      end)
    end
  )
end

local function start_aider()
  if #aider_providers == 1 then
    select_aider_model(aider_providers[1])
    return
  end

  vim.ui.select(aider_providers, {
    prompt = "Select provider:",
    format_item = function(p)
      return p.name
    end,
  }, function(choice)
    if choice then
      select_aider_model(choice)
    end
  end)
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
  {
    name = "Aider",
    buf_name = "aider://terminal",
    start = start_aider, -- Custom start logic for provider/model selection
  },
}

-- ============================================================
-- Main Logic
-- ============================================================

local function handle_tool(tool)
  local win = get_win(tool.buf_name)

  -- 1. If window is open, close it (hide) but keep buffer
  if win then
    vim.api.nvim_win_close(win, true)
    return
  end

  -- 2. If window is closed, check if buffer exists
  local buf = get_buf(tool.buf_name)
  if buf ~= -1 then
    -- Restore the buffer in a new split
    open_split_with_buf(buf)
    return
  end

  -- 3. No window, no buffer -> Start new session
  if tool.start then
    tool.start()
  else
    open_terminal(tool.buf_name, tool.cmd)
  end
end

local function ai_start()
  vim.ui.select(tools, {
    prompt = "Select AI Tool:",
    format_item = function(t)
      return t.name
    end,
  }, function(choice)
    if choice then
      handle_tool(choice)
    end
  end)
end

-- Register keymap
vim.defer_fn(function()
  vim.keymap.set("n", "<leader>ai", ai_start, { desc = "Open AI Tool" })
end, 0)
