local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", false, true)

for _, file in ipairs(plugin_files) do
  local plugin_name = vim.fn.fnamemodify(file, ":t:r")
  if plugin_name ~= "init" then
    require("plugins." .. plugin_name)
  end
end
