local map = vim.keymap.set

local function on_attach(_, _) end

local function on_init(client, _)
  if client:supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = false
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.inlineCompletionProvider = false
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = false,
}

-- Default configured servers.
for _, lsp in ipairs({"gdscript", "sqls", "phpactor"}) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  })
  vim.lsp.enable(lsp)
end

-- pylsp
vim.lsp.config("pylsp", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        pylint = { enabled = false },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
      }
    }
  },
})
vim.lsp.enable("pylsp")

-- clangd
vim.lsp.config("clangd", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--query-driver=/usr/local/bin/g++-14",
    "-header-insertion=never",
  },
})
vim.lsp.enable("clangd")

-- tinymist
vim.lsp.config("tinymist", {
  on_attach = function(_, bufnr)
    on_attach(nil, bufnr)
    map("n", "<leader>tp", "<cmd>:TypstPreview<CR>", { buffer = bufnr, desc = "typst present" })
    map("n", "<leader>tc", "<cmd>:TypstPreviewStop<CR>", { buffer = bufnr, desc = "typst stop present"})
    map("n", "<leader>te", "<cmd>!typst c %:.<CR>", { buffer = bufnr, desc = "typst export to pdf" })
  end,
  on_init = on_init,
  capabilities = capabilities,
})
vim.lsp.enable("tinymist")

-- lua_ls
vim.lsp.config("lua_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = {
        library = {
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
  cmd = { "lua-language-server", "--force-accept-workspace" },
})
vim.lsp.enable("lua_ls")
