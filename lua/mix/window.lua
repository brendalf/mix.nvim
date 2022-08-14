local popup = require("plenary.popup")

local M = {}


function M.open_floating_window(buf)
    local columns = vim.o.columns
    local lines = vim.o.lines
    local width = math.ceil(columns * 0.8)
    local height = math.ceil(lines * 0.8 - 4)

    local _ = popup.create(buf, {
        line = 0,
        col = 0,
        minwidth = width,
        minheight = height,
        border = {},
        padding = { 2, 2, 2, 2 },
        zindex = 10,
    })
end

function M.open_vertical_window(buf)
    vim.cmd("sp")
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_height(0, 30)
end

function M.open_horizontal_window(buf)
    vim.cmd("sp")
    vim.api.nvim_win_set_buf(0, buf)
    vim.api.nvim_win_set_height(0, 30)
end

function M.open_window(buf, config)
    local windows = {
        floating = M.open_floating_window,
        vertical = M.open_vertical_window,
        horizontal = M.open_horizontal_window
    }

    windows[config.window](buf)
end

return M
