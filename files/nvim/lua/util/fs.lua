local M = {}

function M.read_first_line(filepath)
  local expanded = vim.fn.expand(filepath)
	local f = io.open(expanded, "r")
	if not f then
		return nil
	end
	local line = f:read("*l")
	f:close()
	return line
end

function M.read_content_as_path(filepath)
	local line = M.read_first_line(filepath)
	if not line then
		return nil
	end
	return vim.fn.expand(line)
end

-- Reads ~/.todopath and returns the full path, or shows an error
function M.get_todo_base_path()
	local path = M.read_content_as_path("~/.todopath")
	if not path or path == "" then
		vim.notify("~/.todopath is missing or empty", vim.log.levels.ERROR)
		return nil
	end
	return path
end

return M
