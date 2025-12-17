local M = {}

-- Initialisation, makes sure `sessions_dir` exists.
M.init = function()
  vim.fn.mkdir(vim.g.sessions_dir .. "temp/", "p")
end

M.save_all = function()
  local cur = vim.api.nvim_get_current_tabpage()
  local tabids = vim.api.nvim_list_tabpages()
  local sessions = {}
  local n = 1
  for _, v in ipairs(tabids) do
    local s, sess = pcall(vim.api.nvim_tabpage_get_var, v, "session")
    if s then
      if vim.tbl_contains(sessions, sess) then
        vim.notify("duplicate session, not saving: '" .. sess .. "'", vim.log.levels.WARN)
      else
        sessions[n] = sess
        n = n + 1
        vim.api.nvim_set_current_tabpage(v)
        M.save_session(sess)
      end
    end
  end
  vim.api.nvim_set_current_tabpage(cur)
  return sessions
end

M.set_session_cache = function()
  local cur = vim.fn.tabpagenr()
  local str = ""
  local tabids = vim.api.nvim_list_tabpages()
  local first = true
  local n = 1
  for _, v in ipairs(tabids) do
    local s, sess = pcall(vim.api.nvim_tabpage_get_var, v, "session")
    if not s then
      sess = "temp/tab" .. n
      n = n + 1
      vim.api.nvim_set_current_tabpage(v)
      M.save_session(sess)
    elseif vim.fn.filereadable(vim.g.sessions_dir .. sess .. ".vim") then
      vim.api.nvim_set_current_tabpage(v)
      M.save_session(sess)
    end
    if first then
      first = false
      str = str .. "sil LoadSession " .. sess .. "\n"
    else str = str .. "sil tab LoadSession " .. sess .. "\n" end
  end
  vim.api.nvim_set_current_tabpage(tabids[cur])
  str = str .. "tabn " .. cur .. "\nsil exec \"!rm " .. vim.g.sessions_dir .. "temp/*.vim ; rm " .. vim.g.session_cache_file .. "\"\n"
  local file = io.open(vim.g.session_cache_file, "w+")
  if file == nil then return false end
  file:write(str)
  file:close()
  return true
end

-- Save a session by name.
M.save_session = function(name)
  local path = vim.g.sessions_dir .. name .. ".vim"
  vim.cmd("mks! " .. path)
  -- Read session file and filter.
  local file = io.open(path, "r")
  if file == nil then return end
  local cwd = vim.fn.getcwd()
  local lines = {}
  local n = 1
  for line in file:lines() do
    local _, e = line:find("^badd %+%d+ ")
    if e ~= nil then
      local p = line:sub(e + 1, -1)
      if vim.fn.fnamemodify(p, ":p"):find(cwd, 1, true) ~= 1 then
        goto continue
      end
    end
    lines[n] = line
    n = n + 1
    ::continue::
  end
  file:close()
  -- Write filtered session.
  file = io.open(path, "w")
  if file == nil then return end
  file:write(table.concat(lines, "\n") .. "\n")
  file:close()
  -- Append extra data to session file.
  file = io.open(path, "a")
  if file == nil then return end
  file:write("tcd " .. vim.fn.fnamemodify(cwd,":~") .. "\n")
  if vim.t.session ~= nil then file:write("let t:session=\"" .. vim.t.session .. "\"\n") end
  if vim.t.grapple_scope ~= nil then file:write("let t:grapple_scope=\"" .. vim.t.grapple_scope .. "\"\n") end
  file:close()
end

-- Load a session by name.
M.load_session = function(name)
  local path = vim.g.sessions_dir .. name .. ".vim"
  if vim.fn.filereadable(path) ~= 0 then
    vim.cmd("so " .. path)
    if vim.t.grapple_scope then require("grapple").use_scope(vim.t.grapple_scope, { notify = false }) end
    (vim.uv or vim.loop).fs_utime(path, nil, "now")
    return true
  else
    return false
  end
end

-- Delete a session by name.
M.del_session = function(name)
  return os.remove(vim.g.sessions_dir .. name .. ".vim")
end

-- Get a list of paths to all session files.
M.get_sessions = function()
  return vim.fn.split(vim.fn.glob(vim.g.sessions_dir .. "*.vim"), "\n")
end

-- Sets `vim.t.session` to a session name.
M.set_session = function(name)
  vim.t.session = name
  vim.cmd("redrawt")
end

-- Saves the current session in `vim.t.session`.
M.save_current = function()
  if vim.t.session ~= nil then
    M.save_session(vim.t.session)
    return true
  end
  return false
end

return M
