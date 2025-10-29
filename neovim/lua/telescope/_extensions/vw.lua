return require("telescope").register_extension({
  exports = {
    find_files = require("scripts.ts_pickers").ts_vw_find_files,
    live_grep = require("scripts.ts_pickers").ts_vw_live_grep,
  },
})
