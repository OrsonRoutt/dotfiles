return {
  scope = "git_branch",
  icons = true,
  status = true,
  statusline = {
    include_icon = false,
  },
  scopes = {
    {
      name = "cwd_branch",
      desc = "Current working directory and git branch",
      fallback = "cwd",
      cache = {
        event = { "BufEnter", "FocusGained" },
        debounce = 1000,
      },
      resolver = function()
        local git_files = vim.fs.find(".git", { upward = true, stop = vim.loop.os_homedir() })
        if #git_files == 0 then return end
        local root = vim.loop.cwd()
        local result = vim.fn.system({ "git", "symbolic-ref", "--short", "HEAD" })
        local branch = vim.trim(string.gsub(result, "\n", ""))
        local id = string.format("%s:%s", root, branch)
        return id, root
      end,
    }
  }
}
