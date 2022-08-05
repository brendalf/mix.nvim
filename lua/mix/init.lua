local mix = require("mix.wrapper")
local window = require("mix.window")
local utils = require("mix.utils")

local M = {}

function M_complete(_, line, _)
    local completions = vim.split(mix.load_completions(line), "\n")
    return completions
end

function M:commands(opts)
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

function M:validate_opts(opts)
    if not utils.has_value({ "stdout", "floating", "horizontal", "vertical" }, opts["window"]) then
        error(table.concat({ "opt window = '", opts["window"],
            "' is not valid. valid options are: stdout, floating, horizontal, and vertical" }))
    end
end

function M.run(opts)
    local action = table.remove(opts.fargs, 1)
    local args = opts.fargs

    if not action then
        return
    end

    window.open_floating_window(vim.g.mix_nvim_buffer)

    local result = mix.run(action, args)

    vim.api.nvim_buf_set_lines(
        vim.g.mix_nvim_buffer,
        0, -1, false,
        vim.split(result, "\n")
    )
end

function M.setup(user_opts)
    if not vim.g.mix_nvim_buffer then
        vim.g.mix_nvim_buffer = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_buf_set_name(vim.g.mix_nvim_buffer, "mix.nvim output panel")
    end

    local opts = user_opts or {}
    local default_opts = {
        window = "stdout"
    }

    local final_opts = vim.tbl_extend("force", default_opts, opts)

    M:validate_opts(final_opts)

    vim.pretty_print(final_opts)

    M:commands(final_opts)
end

return M
