vim.pack.add({
  {
    src = "https://github.com/nvim-mini/mini.align",
    name = "mini-align",
    version = "stable",
  },
})

vim.defer_fn(function()
  local ok, mini_align = pcall(require, "mini.align")
  if not ok then
    vim.notify("mini-align not found", vim.log.levels.ERROR)
    return
  end

  mini_align.setup({
    -- No need to copy this inside `setup()`. Will be used automatically.
    {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        start = "ga",
        start_with_preview = "gA",
      },

      -- Modifiers changing alignment steps and/or options
      modifiers = {
        -- Main option modifiers
        s = function()
          return vim.fn.input("Enter split pattern: ")
        end,
        j = function()
          local side = vim.fn.input("Justify side (left/center/right): ")
          if side == "left" or side == "center" or side == "right" then
            return side
          else
            vim.notify("Invalid side. Using 'left' as default.", vim.log.levels.WARN)
            return "left"
          end
        end,
        m = function()
          return vim.fn.input("Enter merge delimiter: ")
        end,
        -- Modifiers adding pre-steps
        f = function()
          return vim.fn.input("Enter Lua expression for filtering parts: ")
        end,
        i = function()
          return vim.fn.input("Enter pattern to ignore some split matches: ")
        end,
        p = function()
          return vim.fn.input("Enter pairing pattern: ")
        end,
        t = function()
          return vim.fn.input("Enter trimming pattern: ")
        end,
        -- Delete some last pre-step
        ["<BS>"] = function()
          return nil -- Implementation for deleting last pre-step can be added here
        end,
        -- Special configurations for common splits
        ["="] = function()
          return { split_pattern = "%s*=%s*" }
        end,
        [","] = function()
          return { split_pattern = "%s*,%s*" }
        end,
        ["|"] = function()
          return { split_pattern = "%s*|%s*" }
        end,
        [" "] = function()
          return { split_pattern = "%s+" }
        end,
      },

      -- Default options controlling alignment process
      options = {
        split_pattern = "",
        justify_side = "left",
        merge_delimiter = "",
      },

      -- Default steps performing alignment (if `nil`, default is used)
      steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
      },

      -- Whether to disable showing non-error feedback
      -- This also affects (purely informational) helper messages shown after
      -- idle time if user input is required.
      silent = false,
    },
  })
end, 50)
