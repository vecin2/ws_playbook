local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< MYVIMRC >",
		cwd = "$DOT_FILES_LOC",
	})
end

return M
