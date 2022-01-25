local mix = require'mix-fugitive.mix'
--local view = require'mix-fugitive.view'

local fugitive = {}
local actions = {
    run=mix.run,
    help=mix.help,
}

function fugitive:commands()
    vim.api.nvim_exec([[command M :lua require'mix-fugitive'.mix()]], false)
    vim.api.nvim_exec([[command Mix :lua require'mix-fugitive'.mix()]], false)
    vim.api.nvim_exec([[command Mhelp :lua require'mix-fugitive'.mix("help")]], false)
end

function fugitive.mix(action)
    if action == nil then
       action = "run"
    end

    actions[action]()
end

function fugitive.setup()
    fugitive:commands()
end

return fugitive
