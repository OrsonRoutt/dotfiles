local M = {}

local function write_value(value)
  local t = type(value)
      if t == "number" then io.write(value)
  elseif t == "string" then io.write("\"" .. value .. "\"")
  elseif t == "boolean" then io.write(value and "true" or "false")
  elseif t == "table" then M.write_record(value, false)
  elseif t == "nil" then io.write("nil")
  end
end

M.write_record = function(rec, br)
  local n, v = next(rec, nil)
  io.write("{")
  while n do
    if br then io.write("\n  ") end
    io.write("[")
    write_value(n)
    io.write("]=")
    write_value(v)
    io.write(",")
    n, v = next(rec, n)
  end
  if br then io.write("\n") end
  io.write("}")
end

M.save_file = function(path, cont)
  local file, _ = io.open(path, "w")
  if not file then return false end
  io.output(file)
  io.write("return")
  M.write_record(cont, true)
  file:close()
  return true
end

M.load_file = function(path)
  local file, _ = io.open(path, "r")
  if file == nil then return nil end
  file:close()
  return dofile(path)
end

return M
