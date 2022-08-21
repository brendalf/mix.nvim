local utils = require("mix.utils")
local M = {}

M.defaults = {
    window = "floating"
}

M.possible_values = {
    window = { "floating", "horizontal", "vertical" }
}

function M.validate_config(config)
    if not utils.has_value(M.possible_values.window, config.window) then
        local message = { "opt window = '", config.window,
            "' is not valid. valid options are: ", table.concat(M.possible_values.window, " | ") }
        vim.notify(table.concat(message), vim.log.levels.ERROR)
        return false
    end

    return true
end

function M.get_config(opts)
    local config = opts or {}
    config = vim.tbl_extend("force", M.defaults, config)

    if not M.validate_config(config) then
        error("invalid configuration, check :messages.")
    end

    return config
end

return M
