local popup = require("plenary.popup")

local M = {}

function M.open_floating_window(buf)
    local columns = vim.o.columns
    local lines = vim.o.lines
    local width = math.ceil(columns * 0.8)
    local height = math.ceil(lines * 0.8 - 4)
    -- local left = math.ceil((columns - width) * 0.5)
    -- local top = math.ceil((lines - height) * 0.5 - 1)

    local bufnr = buf or vim.api.nvim_create_buf(false, true)

    local win_id = popup.create(bufnr, {
        line = 0,
        col = 0,
        minwidth = width,
        minheight = height,
        border = {},
        padding = { 2, 2, 2, 2 },
        zindex = 10,
    })

    return bufnr
end

return M
