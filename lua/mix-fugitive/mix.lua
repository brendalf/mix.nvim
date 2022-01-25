local mix = {}

local function run_command(cmd)
    local result = vim.fn.system(cmd)
    return result
end

function mix.refresh_completions()
    local cmd = "mix help | awk -F ' ' '{printf \"%s\\n\", $2}' | grep -E \"[^-#]\\w+\""
    vim.g.mix_complete_list = run_command(cmd)
end

function mix.load_completions(cli_input)
    local l = #(vim.split(cli_input, " "))

    -- Don't print if command already selected
    if l > 2 then
        return ""
    end

    -- Use cache if list has been already loaded
    if vim.g.mix_complete_list then
        return vim.g.mix_complete_list
    end

    mix.refresh_completions()

    return vim.g.mix_complete_list
end

function mix.run(action, args)
    local args_as_str = table.concat(args, " ")
    local cmd = {"mix", action, args_as_str}
    return run_command(table.concat(cmd, " "))
end

return mix
