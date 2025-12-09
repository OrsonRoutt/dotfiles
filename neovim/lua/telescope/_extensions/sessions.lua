return require("telescope").register_extension({
  exports = {
    sessions = require("scripts.ts_pickers").ts_sessions,
  },
})
