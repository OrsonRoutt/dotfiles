return {
  keys = {
    { ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "quickfix expand" },
    { "<", function() require("quicker").collapse() end, desc = "quickfix collapse" },
  }
}
