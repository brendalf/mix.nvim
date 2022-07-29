local mix = require("mix.wrapper")

local M = {}

function M_complete(_, line, _)
    local completions = vim.split(mix.load_completions(line), "\n")
    return completions
end

function M:commands()
    local mix_complete_options = {
        nargs = "*",
        range = true,
        complete = M_complete
    }
    vim.api.nvim_create_user_command("Mix", M.run, mix_complete_options)
    vim.api.nvim_create_user_command("M", M.run, mix_complete_options)
    vim.api.nvim_create_user_command(
        "MixRefreshCompletions",
        function()
            mix.refresh_completions()
            vim.notify("Mix commands refreshed")
        end,
        {}
    )
end

function M.run(opts)
    local action = table.remove(opts.fargs, 1)
    local args = opts.fargs

    if not action then
        return
    end

    local result = mix.run(action, args)
    print(result)
end

function M.setup(opts)
    vim.pretty_print(opts)
    M:commands()
end

return M
