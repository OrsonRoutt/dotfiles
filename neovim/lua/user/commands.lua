local user_command = vim.api.nvim_create_user_command

user_command("Cfg", ":Project neovim", {})
user_command("Save", ":SessionSave main", {})
user_command("Load", ":SessionLoad main", {})
