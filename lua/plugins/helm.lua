vim.pack.add({
  {
    src = "https://github.com/towolf/vim-helm.git",
    name = "vim-helm",
  },
})

vim.defer_fn(function()
  vim.filetype.add({
    extension = {
      yaml = function(path)
        if vim.fs.find("Chart.yaml", {
              path = vim.fs.dirname(path),
              upward = true,
            })[1] then
          return "helm"
        end
        return "yaml"
      end,
      yml = function(path)
        if vim.fs.find("Chart.yaml", {
              path = vim.fs.dirname(path),
              upward = true,
            })[1] then
          return "helm"
        end
        return "yaml"
      end,
      tpl = "helm",
      tmpl = "helm",
    },
  })
  vim.lsp.config("helm_ls", {
    cmd = { "helm_ls", "serve" },
    filetypes = { "helm", "helmfile", "yaml", "yml" },
    root_dir = vim.fs.dirname(vim.fs.find({ "Chart.yaml" }, { upward = true })[1]),
    settings = {
      ["helm-ls"] = {
        yamlls = {
          path = "yaml-language-server",
          enabledForFilesGlob = "*.{yaml,yml}",
        },
      },
    },
  })

  vim.lsp.enable("helm_ls")
end, 100) -- Load after LSP setup
