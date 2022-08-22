local popup = require("plenary.popup")

local M = {}


function M.open_floating_window()
    local buf = vim.api.nvim_create_buf(false, true)

    local columns = vim.o.columns
    local lines = vim.o.lines
    local width = math.ceil(columns * 0.8)
    local height = math.ceil(lines * 0.8 - 4)

    local win_id = popup.create(buf, {
        line = 0,
        col = 0,
        minwidth = width,
        minheight = height,
        border = {},
        borderchars = {"-", "|", "-", "|", "┌", "┐", "┘", "└"},
        padding = { 2, 2, 2, 2 },
        zindex = 10,
    })

    return buf, win_id
end

function M.open_vertical_window()
    vim.cmd("bot vnew")

    return vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win()
end

function M.open_horizontal_window()
    vim.cmd("top new")

    return vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win()
end

function M.open_window(config)
    local windows = {
        floating = M.open_floating_window,
        vertical = M.open_vertical_window,
        horizontal = M.open_horizontal_window
    }

    local buf_id, win_id = windows[config.window]()

    vim.bo[buf_id].filetype = "MixOutputPanel"
    vim.wo[win_id].number = false
    vim.wo[win_id].relativenumber = false

    return buf_id
end

return M
