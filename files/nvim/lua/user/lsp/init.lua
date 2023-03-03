local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

--require("user.lsp.lsp-installer")
require("user.lsp.mason")
require("user.lsp.handlers").setup()
require("user.lsp.null-ls")
require("user.lsp.settings.pedro-emmetls")

local opts = {
	on_attach = require("user.lsp.handlers").on_attach,
	capabilities = require("user.lsp.handlers").capabilities,
}
local pylsp_opts = require("user.lsp.settings.pylsp")
opts = vim.tbl_deep_extend("force", pylsp_opts, opts)
require("lspconfig").pylsp.setup(opts)
