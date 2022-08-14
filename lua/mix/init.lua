local mix = require("mix.wrapper")
local window = require("mix.window")
local config = require("mix.config")

local M = {}

function M_complete(_, line, _)
    local completions = vim.split(mix.load_completions(line), "\n")
    return completions
end

function M:commands()
    local mix_complete_options = {
        nargs = "*",
        range = true,
        complete = M_complete,
    }
    vim.api.nvim_create_user_command("Mix", M.run, mix_complete_options)
    vim.api.nvim_create_user_command("M", M.run, mix_complete_options)
    vim.api.nvim_create_user_command("MixRefreshCompletions", function()
        mix.refresh_completions()
        vim.notify("Mix commands refreshed")
    end, {})
end

function M.run(opts)
    local action = table.remove(opts.fargs, 1)
    local args = opts.fargs

    if not action then
        return
    end

    window.open_window(vim.g.mix_nvim_buffer, vim.g.mix_nvim_config)

    mix.run(vim.g.mix_nvim_buffer, action, args)
end

function M.setup(user_opts)
    if not vim.g.mix_nvim_buffer then
        vim.g.mix_nvim_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(vim.g.mix_nvim_buffer, "mix.nvim output panel")
    end

    vim.g.mix_nvim_config = config.get_config(user_opts)

    M:commands()
end

return M
