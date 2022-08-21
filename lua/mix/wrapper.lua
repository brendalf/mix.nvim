local mix_exs = require("mix.exs")
local window = require("mix.window")

local M = {
    mix_exs_path_cache = nil,
}

function M.refresh_completions()
    local cmd = "mix help | awk -F ' ' '{printf \"%s\\n\", $2}' | grep -E \"[^-#]\\w+\""
    vim.g.mix_complete_list = vim.fn.system(cmd)
    vim.notify("Mix commands refreshed")
end

function M.load_completions(cli_input)
    local cli_input_cleaned = vim.fn.trim(cli_input)
    local l = #(vim.split(cli_input_cleaned, " "))

    -- Don't print if command already selected
    if l > 1 then
        return ""
    end

    -- Use cache if list has been already loaded
    if vim.g.mix_complete_list then
        return vim.g.mix_complete_list
    end

    M.refresh_completions()

    return vim.g.mix_complete_list
end

function M.run(action, args)
    local args_as_str = table.concat(args, " ")

    local cd_cmd = ""
    local mix_exs_path = M.mix_exs()


    if mix_exs_path then
        cd_cmd = mix_exs_path
    end

    local cmd = table.concat({
        "mix",
        action,
        args_as_str
    }, " ")

    window.open_window(vim.g.mix_nvim_config)

    vim.fn.termopen(cmd, {
        cwd = cd_cmd,
        on_exit = function()
            if action == "deps.get" then
                M.refresh_completions()
            end
        end
    })
end

function M.mix_exs()
    if not M.mix_exs_path_cache then
        local mix_ops = mix_exs.path_mix_exs()
        if mix_ops.file_exists then
            M.mix_exs_path_cache = mix_ops.mix_dir
        end
    end

    return M.mix_exs_path_cache
end

return M
