local M = {}

-- Initialisation, makes sure `sessions_dir` exists.
M.init = function()
  vim.fn.mkdir(vim.g.sessions_dir, "p")
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
