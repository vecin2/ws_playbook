#autodetect filetype as ansible so it can activate ansible ansiblels
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.yml", "*.yaml"},
    callback = function()
        local function find_ansible_root()
            local cwd = vim.fn.expand("%:p:h") -- Get current file's directory
            local root_markers = { "ansible.cfg", "roles", "group_vars", "inventory" }
            while cwd ~= "/" do
                for _, marker in ipairs(root_markers) do
                    if vim.fn.isdirectory(cwd .. "/" .. marker) == 1 or vim.fn.filereadable(cwd .. "/" .. marker) == 1 then
                        return cwd
                    end
                end
                cwd = vim.fn.fnamemodify(cwd, ":h") -- Move up a directory
            end
            return nil
        end

        if find_ansible_root() then
            vim.bo.filetype = "yaml.ansible"
        end
    end
})
