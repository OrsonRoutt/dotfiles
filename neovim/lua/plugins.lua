return {
  {
    "folke/which-key.nvim",
    lazy = false,
    opts = function()
      require("scripts.theme").load_plugin_hls("whichkey")
      return require("configs.whichkey")
    end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = function() return require("configs.mason") end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "ms-jpq/coq_nvim" },
    config = function() require("configs.lspconfig") end,
  },
  {
    "ms-jpq/coq_nvim",
    branch = "coq",
    dependencies = { "windwp/nvim-autopairs" },
    init = function() vim.g.coq_settings = require("configs.coq") end,
  },
  {
    "windwp/nvim-autopairs",
    opts = function() return require("configs.autopairs") end,
    config = function(_, opts) require("nvim-autopairs").setup(opts) end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects", "kevinhwang91/nvim-ufo" },
    build = ":TSUpdate",
    opts = function() return require("configs.treesitter") end,
    config = function(_, opts)
      require("nvim-treesitter").install(opts.install)
      local ft = {}
      local n = 1
      for _, v in ipairs(opts.install) do
        for _, f in ipairs(vim.treesitter.language.get_filetypes(v)) do
          ft[n] = f
          n = n + 1
        end
      end
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = function()
          vim.treesitter.start()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = function() return require("configs.textobjects") end,
    config = function(_, opts) require("nvim-treesitter-textobjects").setup(opts) end,
  },
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function() return require("configs.oil_opts") end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    cmd = "Telescope",
    opts = function()
      require("scripts.theme").load_plugin_hls("telescope")
      return require("configs.telescope_opts")
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make"
  },
  {
    "cbochs/grapple.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    opts = function()
      vim.g.grapple = true
      return require("configs.grapple_opts")
    end,
  },
  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreviewUpdate", "TypstPreview", "TypstPreviewStop", "TypstPreviewToggle" },
    opts = require("configs.typst-preview"),
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Gitsigns",
    opts = function() return require("configs.gitsigns") end,
  },
  {
    "max397574/better-escape.nvim",
    lazy = false,
    opts = function() return require("configs.better_escape") end,
  },
  {
    "vimwiki/vimwiki",
    ft = "vimwiki",
    keys = {
      { "<leader>ww", desc = "VimwikiIndex (Lazy)" },
      { "<leader>wt", desc = "VimwikiTabIndex (Lazy)" },
      { "<leader>ws", desc = "VimwikiUISelect (Lazy)" },
    },
    init = function() require("configs.vimwiki") end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = function() return require("configs.ufo_opts") end,
    config = function(_, opts) require("ufo").setup(opts) end,
  },
  {
    'stevearc/quicker.nvim',
    ft = "qf",
    opts = function() return require("configs.quicker_opts") end,
  }
}
