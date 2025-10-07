return require("telescope").register_extension({
  exports = {
    terms = require("scripts.ts_pickers").ts_terms,
  },
})
