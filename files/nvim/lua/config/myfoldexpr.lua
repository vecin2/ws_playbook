local augroup = vim.api.nvim_create_augroup("filetype_lua", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "lua",
  callback = function()
    -- Set foldmethod to expr (expression-based folding)
    vim.opt.foldmethod = "expr"
    
    -- Set foldexpr to a Lua function that performs the folding logic
    vim.opt.foldexpr = "v:lua.fold_expr()"
  end,
})

-- Define the folding expression in Lua
_G.fold_expr = function()
  local line = vim.fn.getline(vim.fn.line('.'))  -- Get the current line

  if line:match("{{{") then
    return '>1'  -- Fold lines with `--{{{` or `--}}}`
	elseif line:match("--}}}") then
    return '<1'  -- Fold lines with `--{{{` or `--}}}`
  else
    -- Delegate to Tree-sitter for internal folding
    local ts_fold_level = vim.treesitter.foldexpr()
		local current_fold_level = vim.fn.foldlevel(vim.fn.line('.'))
    -- Adjust Tree-sitter result to reflect being inside a level 1 fold
		local max_fold_level = math.max(ts_fold_level,  current_fold_level)
		return max_fold_level
	end
  -- return vim.fn["nvim_treesitter#foldexpr"]()  -- Default Treesitter folding
end
-- }}}

vim.api.nvim_create_user_command('TestFoldExpr', function(opts)
  local line = opts.args and tonumber(opts.args) or vim.fn.line('.')

  -- Set the cursor to the specified line
  vim.fn.cursor(line, 1)  -- Move to the specified line (line, column)

  -- Get the line number after moving the cursor
  local current_lnum = vim.fn.line('.')  -- This reflects the correct current line number

  -- Print the fold expression result for the current line
  print("Fold result for line " .. current_lnum .. ": " .. _G.fold_expr())
end, { nargs = '?' })

--pedro{{{
--d
--p
--}}}

