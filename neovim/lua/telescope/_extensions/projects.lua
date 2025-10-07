return require("telescope").register_extension({
  exports = {
    projects = require("scripts.ts_pickers").ts_projects,
  },
})
