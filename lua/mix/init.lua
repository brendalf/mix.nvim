local mix = require("mix.wrapper")
local window = require("mix.window")

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

    window.open_floating_window(vim.g.mix_nvim_buffer)

    local result = mix.run(action, args)

    vim.api.nvim_buf_set_lines(vim.g.mix_nvim_buffer, 0, -1, false, vim.split(result, "\n"))
end

function M.setup()
    if not vim.g.mix_nvim_buffer then
        vim.g.mix_nvim_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(vim.g.mix_nvim_buffer, "mix.nvim output panel")
    end

    M:commands()
end

return M
