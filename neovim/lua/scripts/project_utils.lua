local M = {}

M.load_projects = function()
  if not projects then
    _G.projects = require("scripts.fileio").load_file(vim.g.projects_file)
    if not projects then
      vim.notify("failed to load projects file", vim.log.levels.ERROR)
      return false
    end
    return true
  end
  return true
end

M.load_project = function(name)
  local project = projects[name]
  if not project then
    vim.notify("project does not exist: '"  .. name .. "'", vim.log.levels.ERROR)
    return
  end
  if project[1] then vim.cmd("cd " .. project[1]) end
  if project[3] then vim.cmd("e " .. project[3]) end
  project[4] = os.time()
  if project[5] then require("grapple").use_scope(project[5]) end
  require("scripts.fileio").save_file(vim.g.projects_file, projects)
end

return M
