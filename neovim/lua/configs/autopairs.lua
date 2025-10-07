local npairs = require("nvim-autopairs")

_G.user = {}

_G.user.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({"selected"}).selected ~= -1 then
      return npairs.esc("<C-y>")
    else return npairs.esc("<C-e>") .. npairs.autopairs_cr() end
  else return npairs.autopairs_cr() end
end

_G.user.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({"mode"}).mode == "eval" then
    return npairs.esc("<C-e>") .. npairs.autopairs_bs()
  else return npairs.autopairs_bs() end
end

return {
  map_cr = false,
  map_bs = false,
  fast_wrap = {},
}
