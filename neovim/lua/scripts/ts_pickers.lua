local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")

local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local find_files = require("telescope.builtin").find_files
local live_grep = require("telescope.builtin").live_grep

local function get_terms()
  return vim.tbl_filter(
    function(buf)
      return vim.bo[buf].buftype == "terminal"
    end, vim.api.nvim_list_bufs())
end

M.ts_terms = function(opts)
  opts = opts or {}

  local bufnrs = get_terms()
  if #bufnrs == 0 then
    vim.notify("no terminal buffers are open")
    return
  end

  local bufs = {}
  for _, buf in ipairs(bufnrs) do
    table.insert(bufs, { bufnr = buf, flag = "", info = vim.fn.getbufinfo(buf)[1] })
  end

  if not opts.bufnr_width then
    opts.bufnr_width = #tostring(math.max(unpack(bufnrs)))
  end

  pickers.new(opts, {
    prompt_title = "Terminals",
    finder = finders.new_table {
      results = bufs,
      entry_maker = make_entry.gen_from_buffer(opts),
    },
    previewer = conf.grep_previewer(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(_, map)
      map({ "i", "n" }, "<M-d>", actions.delete_buffer)
      return true
    end,
  }):find()
end

M.ts_projects = function(opts)
  opts = opts or {}

  local p = require("scripts.project_utils")
  if not p.load_projects() then return end

  local proj = {}
  local n = 1
  for k, v in pairs(_G.projects) do
    proj[n] = { k, v[1], v[2], v[3], v[4] }
    n = n + 1
  end
  table.sort(proj, function(a, b) return a[5] > b[5] end)

  pickers.new(opts, {
    prompt_title = "Projects",
    finder = finders.new_table {
      results = proj,
      entry_maker = function(e)
        local path = e[3] ~= nil and e[3] or e[4]
        if path ~= nil then
          if e[2] ~= nil then path = e[2] .. path end
        else path = "" end
        return {
          path = path,
          display = e[1],
          ordinal = e[1],
        }
      end,
    },
    previewer = conf.file_previewer(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local sel = action_state.get_selected_entry()
        p.load_project(sel.ordinal)
      end)
      actions.select_tab:replace(function()
        actions.close(prompt_bufnr)
        vim.cmd("tabe")
        local sel = action_state.get_selected_entry()
        p.load_project(sel.ordinal)
      end)
      return true
    end,
  }):find()
end

M.ts_vw_find_files = function(opts)
  opts = opts or {}
  local wiki = opts.i or 0

  if vim.g.loaded_vimwiki == nil then
    require("lazy").load({ plugins = { "vimwiki" } })
  end

  if wiki >= #vim.g.vimwiki_wikilocal_vars then
    vim.notify("wiki does not exist: " .. wiki, vim.log.levels.ERROR)
    return
  end

  opts = vim.tbl_deep_extend("keep", opts, { prompt_title = "Find Files (VimWiki #" .. wiki .. ")" })
  opts.cwd = vim.g.vimwiki_wikilocal_vars[wiki + 1].path
  find_files(opts)
end


M.ts_vw_live_grep = function(opts)
  opts = opts or {}
  local wiki = opts.i or 0

  if vim.g.loaded_vimwiki == nil then
    require("lazy").load({ plugins = { "vimwiki" } })
  end

  if wiki >= #vim.g.vimwiki_wikilocal_vars then
    vim.notify("wiki does not exist: " .. wiki, vim.log.levels.ERROR)
    return
  end

  opts = vim.tbl_deep_extend("keep", opts, { prompt_title = "Live Grep (VimWiki #" .. wiki .. ")" })
  opts.cwd = vim.g.vimwiki_wikilocal_vars[wiki + 1].path
  live_grep(opts)
end

M.ts_sessions = function(opts)
  opts = opts or {}

  local s = require("scripts.sessions")

  local fs = vim.uv or vim.loop
  local list = s.get_sessions()
  local sessions = {}
  for i=1,#list do
    local v = list[i]
    local stat = fs.fs_stat(v)
    sessions[i] = { v, vim.fn.fnamemodify(v, ":t:r"), stat ~= nil and stat.mtime.sec or 0 }
  end
  table.sort(sessions, function(a, b) return a[3] > b[3] end)

  pickers.new(opts, {
    prompt_title = "Sessions",
    finder = finders.new_table {
      results = sessions,
      entry_maker = function(e)
        return {
          path = e[1],
          display = e[2],
          ordinal = e[2],
        }
      end,
    },
    previewer = conf.file_previewer(opts),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local sel = action_state.get_selected_entry()
        s.load_session(sel.ordinal)
      end)
      actions.select_tab:replace(function()
        actions.close(prompt_bufnr)
        vim.cmd("tabe")
        local sel = action_state.get_selected_entry()
        s.load_session(sel.ordinal)
      end)
      map({ "i", "n" }, "<M-d>", function()
        local current_picker = action_state.get_current_picker(prompt_bufnr)
        current_picker:delete_selection(function(sel)
          return s.del_session(sel.ordinal)
        end)
      end)
      return true
    end,
  }):find()
end

return M
