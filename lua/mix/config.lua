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
        error(table.concat({ "opt window = '", config.window,
            "' is not valid. valid options are: ", table.concat(M.possible_values.window, " | ") }))
    end
end

function M.get_config(opts)
    local config = opts or {}
    config = vim.tbl_extend("force", M.defaults, config)

    M:validate_config(config)

    return config
end

return M
