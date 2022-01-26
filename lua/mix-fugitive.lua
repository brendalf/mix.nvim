local mix = require'mix-fugitive.mix'
--local view = require'mix-fugitive.view'

local fugitive = {}
--local actions = {
    --run=mix.run,
    --help=mix.help,
--}

function M_fugitive_complete(_, line, _)
    return mix.load_completions(line)
end

function fugitive:commands()
    vim.api.nvim_exec([[command! -nargs=* -range -complete=custom,v:lua.M_fugitive_complete M :lua require'mix-fugitive'.load_command(<line1>, <line2>, <count>, unpack({<f-args>}))]], false)
    vim.api.nvim_exec([[command! -nargs=* -range -complete=custom,v:lua.M_fugitive_complete Mx :lua require'mix-fugitive'.load_command(<line1>, <line2>, <count>, unpack({<f-args>}))]], false)
    vim.api.nvim_exec([[command! -nargs=* -range -complete=custom,v:lua.M_fugitive_complete Mix :lua require'mix-fugitive'.load_command(<line1>, <line2>, <count>, unpack({<f-args>}))]], false)
end

function fugitive.run(opts)
    local action = opts.cmd
    local args = opts.args

    --if action == nil then
       --action = "run"
    --end

    --actions[action](args)

    local result = mix.run(action, args)
    print(result)
end

function fugitive.load_command(start_line, end_line, count, cmd, ...)
    local args = {...}

    if not cmd then
        return
    end

    --if cmd == nil then
        --fugitive.run_command()
        --return
    --end

    local user_opts = {
        start_line = start_line,
        end_line = end_line,
        count = count,
        cmd = cmd,
        args = args
    }

    fugitive.run(user_opts)
end

function fugitive.setup()
    fugitive:commands()
end

return fugitive
