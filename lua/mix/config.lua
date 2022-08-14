local utils = require("mix.utils")
local M = {}

M.defaults = {
    window = "floating"
}

function M:validate_config(config)
    if not utils.has_value({ "floating", "horizontal", "vertical" }, config.window) then
        error(table.concat({ "opt window = '", config["window"],
            "' is not valid. valid options are: stdout, floating, horizontal, and vertical" }))
    end
end

function M:get_config(opts)
    local config = opts or {}
    config = vim.tbl_extend("force", M.defaults, config)

    M:validate_config(config)

    return config
end

return M
