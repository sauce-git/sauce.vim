-- ============================================================
-- Aider Integration
-- ============================================================

local aider = {}

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

-- Open aider in a right vertical split
local function open_aider(model)
  vim.cmd("vsplit")
  vim.cmd("wincmd L")
  vim.cmd("vertical resize 80")
  vim.cmd("terminal aider --model " .. model)
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
