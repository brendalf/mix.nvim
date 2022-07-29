local mix = require("mix.wrapper")

local M = {}

function M_complete(_, line, _)
    return mix.load_completions(line)
end

function M:commands()
    vim.api.nvim_exec([[command! -nargs=* -range -complete=custom,v:lua.M_complete M :lua require'mix'.load_command(<line1>, <line2>, <count>, unpack({<f-args>}))]]
        , false)
    vim.api.nvim_exec([[command! -nargs=* -range -complete=custom,v:lua.M_complete Mix :lua require'mix'.load_command(<line1>, <line2>, <count>, unpack({<f-args>}))]]
        , false)
end

function M.run(opts)
    local action = opts.cmd
    local args = opts.args

    local result = mix.run(action, args)
    print(result)
end

function M.load_command(start_line, end_line, count, cmd, ...)
    local args = { ... }

    if not cmd then
        return
    end

    local user_opts = {
        start_line = start_line,
        end_line = end_line,
        count = count,
        cmd = cmd,
        args = args
    }

    M.run(user_opts)
end

function M.setup()
    M:commands()
end

return M
