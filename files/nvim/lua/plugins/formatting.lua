local function get_prettier_command(mode, filename)
	if mode == "local" then
		local root_dir = vim.fs.root(filename, { "package.json", "node_modules" })
		if root_dir then
			local prettier_cmd = root_dir .. "/node_modules/.bin/prettier"
			vim.notify("Using local Prettier: " .. prettier_cmd, vim.log.levels.WARN)
			return prettier_cmd
		else
			vim.notify("⚠ No local Prettier found! Falling back to global Prettier.", vim.log.levels.WARN)
			return nil
		end
	elseif mode == "mason" then
		if vim.fn.executable("prettier") == 1 then
			vim.notify("Using Mason/global Prettier", vim.log.levels.WARN)
			return "prettier"
		else
			vim.notify(
				"❌ Mason/global Prettier not found! Install it with `:MasonInstall prettier` or `npm install -g prettier`.",
				vim.log.levels.ERROR
			)
			return nil
		end
	end
end

return { -- Autoformat
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		-- format_on_save = function(bufnr)
		-- 	-- Disable "format_on_save lsp_fallback" for languages that don't
		-- 	-- have a well standardized coding style. You can add additional
		-- 	-- languages here or re-enable it for the disabled ones.
		-- 	local disable_filetypes = { c = true, cpp = true }
		-- 	local lsp_format_opt
		-- 	if disable_filetypes[vim.bo[bufnr].filetype] then
		-- 		lsp_format_opt = "never"
		-- 	else
		-- 		lsp_format_opt = "fallback"
		-- 	end
		-- 	return {
		-- 		timeout_ms = 10000,
		-- 		lsp_format = lsp_format_opt,
		-- 	}
		-- end,
		formatters = {
			ansible_lint = {
				command = "ansible-lint",
				args = { "--fix", "--nocolor", vim.fn.expand("%:p") },
				stdin = false, -- ansible-lint requires files as input
			},
			prettier_local = {
				command = function(_, ctx)
					return get_prettier_command("local", ctx.filename)
				end,
				args = function(_, ctx)
					return { "--stdin-filepath", ctx.filename }
				end,
			},
			prettier_mason = {
				command = function(_, _)
					return get_prettier_command("mason")
				end,
				args = function(_, ctx)
					return { "--stdin-filepath", ctx.filename }
				end,
			},
		},
		formatters_by_ft = {
			-- You can use 'stop_after_first' to run the first available formatter from the list
			-- TODO: try prettierd which seem to not work - javascript = { "prettierd", "prettier", stop_after_first = true },
			javascript = { "prettier_local", "prettier_mason", stop_after_first = true },
			typescript = { "prettier_local", "prettier_mason", stop_after_first = true },
			javascriptreact = { "prettier_local", "prettier_mason", stop_after_first = true },
			typescriptreact = { "prettier_local", "prettier_mason", stop_after_first = true },
			svelte = { "prettier_local", "prettier_mason", stop_after_first = true },
			css = { "prettier_local", "prettier_mason", stop_after_first = true },
			scss = { "prettier_local", "prettier_mason", stop_after_first = true },
			html = { "prettier_local", "prettier_mason", stop_after_first = true },
			htmlangular = { "prettier_local", "prettier_mason", stop_after_first = true },
			json = { "prettier_local", "prettier_mason", stop_after_first = true },
			yaml = { "prettier_local", "prettier_mason", stop_after_first = true },
			markdown = { "prettier_local", "prettier_mason", stop_after_first = true },
			graphql = { "prettier_local", "prettier_mason", stop_after_first = true },
			liquid = { "prettier_local", "prettier_mason", stop_after_first = true },
			lua = { "stylua" },
			python = { "isort", "black" },
		},
	},
}
