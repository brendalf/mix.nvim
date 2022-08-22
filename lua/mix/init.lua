local mix = require("mix.wrapper")
local config = require("mix.config")

local M = {}

function M_complete(_, line, _)
    local completions = vim.split(mix.load_completions(line), "\n")
    return completions
end

function M.commands()
    local mix_complete_options = {
        nargs = "*",
        range = true,
        complete = M_complete,
    }
    vim.api.nvim_create_user_command("Mix", M.run, mix_complete_options)
    vim.api.nvim_create_user_command("M", M.run, mix_complete_options)
    vim.api.nvim_create_user_command("MixRefreshCompletions", mix.refresh_completions, {})
end

function M.run(opts)
    local action = table.remove(opts.fargs, 1)
    local args = opts.fargs

    if not action then
        return
    end

    mix.run(action, args)
end

function M.setup(user_opts)
    vim.g.mix_nvim_config = config.get_config(user_opts)

    M.commands()
end

return M
