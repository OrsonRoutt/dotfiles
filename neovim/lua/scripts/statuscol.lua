-- Referenced from https://github.com/luukvbaal/statuscol.nvim
local ffi = require("ffi")
ffi.cdef([[
	typedef struct {} Error;
	typedef struct {} win_T;
	typedef struct {
		int start;
		int level;
		int llevel;
		int lines;
	} foldinfo_T;
	foldinfo_T fold_info(win_T* wp, int lnum);
	win_T *find_window_by_handle(int Window, Error *err);
]])
local error = ffi.new("Error")

local function get_fold(lnum)
  local foldinfo = ffi.C.fold_info(ffi.C.find_window_by_handle(vim.g.statusline_winid, error), lnum)
  return lnum == foldinfo.start and (foldinfo.lines > 0 and "" or "") or " "
end

_G.get_statuscol = function() return "%s" .. get_fold(vim.v.lnum) .. " %l " end
