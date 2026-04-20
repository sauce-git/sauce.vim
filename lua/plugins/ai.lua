-- ============================================================
-- Aider Integration
-- ============================================================

local aider = {}

local AIDER_BUF_NAME = "aider://terminal"

-- Provider config (add/remove providers here)
aider.providers = {
  {
    name = "OpenRouter",
    prefix = "openrouter/",
    list_cmd = { "aider", "--list-models", "openrouter/" },
  },
  -- Examples:
  -- {
  --   name = "Anthropic",
  --   prefix = "anthropic/",
  --   list_cmd = { "aider", "--list-models", "anthropic/" },
  -- },
  -- {
  --   name = "Ollama (local)",
  --   prefix = "ollama/",
  --   list_cmd = { "aider", "--list-models", "ollama/" },
  -- },
}

-- Helper: Find window containing the Aider buffer
local function get_aider_win()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_name(buf) == AIDER_BUF_NAME then
      return win
    end
  end
  return nil
end

-- Helper: Delete the Aider buffer (cleanup)
local function clean_aider_buf()
  local buf = vim.fn.bufnr(AIDER_BUF_NAME)
  if buf ~= -1 then
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end

-- Open aider in a right vertical split
local function open_aider(model)
  -- Ensure no old buffer exists before opening
  clean_aider_buf()

  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("vertical resize 80")
  vim.cmd("terminal aider --model " .. model)

  -- Set unique name for easy identification
  vim.api.nvim_buf_set_name(0, AIDER_BUF_NAME)
  vim.cmd("startinsert")
end

-- Async load model list then prompt selection
local function select_model(provider)
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
            open_aider(choice)
          end
        end)
      end)
    end
  )
end

-- Select provider (skip if only one configured)
local function aider_start()
  -- Toggle OFF: If window is open, close it and clean up
  local win = get_aider_win()
  if win then
    vim.api.nvim_win_close(win, true)
    clean_aider_buf()
    return
  end

  -- Toggle ON: Clean up any hidden buffer, then open modal
  clean_aider_buf()

  if #aider.providers == 1 then
    select_model(aider.providers[1])
    return
  end

  vim.ui.select(aider.providers, {
    prompt = "Select provider:",
    format_item = function(p) return p.name end,
  }, function(choice)
    if choice then
      select_model(choice)
    end
  end)
end

-- Register keymap
vim.defer_fn(function()
  vim.keymap.set("n", "<leader>ai", aider_start, { desc = "Run Aider" })
end, 0)
