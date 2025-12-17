local user_command = vim.api.nvim_create_user_command
local map = vim.keymap.set

user_command("Cfg", ":Project neovim", {})
user_command("Save", ":SaveSession main", {})
user_command("Load", ":LoadSession main", {})

local gitN = 1
local git = {
  "Get it twisted.\nIf you lock in you can do anything.\n\n",
  "Get it twisted.\nYour actions impact nothing.\nYour fate is predetermined.\nThe only thing you can change is your reaction to it.\n\n",
  "Get it twisted.\nYou can do anything you set your mind to.\nThe world is a playground designed for you and only you to achieve your highest level ambitions.\nIf you wait 90 minutes to wake up to drink your first cup of coffee nothing can stop you.\nIf you duct tape your mouth when you fall asleep nothing can stop you.\n\n",
  "Get it twisted.\nYou are a pawn in a universe chess match.\nYou mean nothing to God, if they even exist.\nYou’re a rounding error.\nYou’re two pennies on a fortune 500 company’s balance sheet.\nThey don’t care about you in the slightest.\n\n",
  "Get it twisted.\nEveryone gets what they deserve in life.\nIf you put effort in you can achieve anything.\nSuccessful people are better people.\n\n",
  "Get it twisted.\nThe circumstances surrounding your birth determine where you are going to go.\nNothing else matters at all.\nYour own level of education.\nYour attitude.\nYour level of effort.\nYour friends.\nYour business.\nYour credentials...\n\n",
  "Motherfucker!\n\n",
}

map("n", "<leader>git", function()
  local str = git[gitN]
  if gitN >= #git then gitN = 1
  else gitN = gitN + 1 end
  vim.api.nvim_paste(str, false, -1)
end, { desc = "GIT." })
