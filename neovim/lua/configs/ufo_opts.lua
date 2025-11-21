local function get_selector(bufnr)
    local function handle_fallback_exception(err, provider_name)
        if type(err) == "string" and err:match("UfoFallbackException") then
            return require("ufo").getFolds(bufnr, provider_name)
        else return require("promise").reject(err) end
    end
    return require("ufo").getFolds(bufnr, "lsp"):catch(function(err)
        return handle_fallback_exception(err, "treesitter")
    end):catch(function(err)
        return handle_fallback_exception(err, "indent")
    end)
end

return {
  open_fold_hl_timeout = 150,
  provider_selector = function(_, _, _) return get_selector end,
  preview = {
    win_config = {
      border = "none",
      winblend = 0,
      winhighlight = "Normal:NormalFloat",
    },
    mappings = {
      scrollB = "",
      scrollF = "",
      scrollU = "<C-u>",
      scrollD = "<C-d>",
      scrollE = "",
      scrollY = "",
      jumpTop = "",
      jumpBot = "",
      close = "q",
      switch = "<Tab>",
      trace = "<CR>",
    },
  },
}
