local stub = require("luassert.stub")

local mix = require("mix")
local wrapper = require("mix.wrapper")
local window = require("mix.window")
local config = require("mix.config")

describe("init", function()
    before_each(function()
        vim.g.mix_nvim_buffer = nil
    end)

    it("should setup plugin", function()
        local s = stub(config, "get_config", {})

        mix.setup()

        assert.stub(config.get_config).was_called()

        s:revert()
    end)

    it("should create M, Mix and MixRefreshCompletions commands", function()
        mix:commands()

        local vim_commands = vim.api.nvim_get_commands({})
        assert.is_not_nil(vim_commands["M"])
        assert.is_not_nil(vim_commands["Mix"])
        assert.is_not_nil(vim_commands["MixRefreshCompletions"])
    end)

    it("should not run mix command without arguments", function()
        local s_run = stub(wrapper, "run")

        mix.run({
            fargs = {},
        })

        assert.stub(wrapper.run).was_not_called()
        s_run:revert()
    end)

    it("should run the mix command and send the output to a window", function()
        local s_open_window = stub(window, "open_window")

        vim.g.mix_nvim_config = { window = "floating"  }

        mix.run({
            fargs = { "Mix", "deps.get" },
        })

        assert.stub(window.open_window).was_called()

        s_open_window:revert()
    end)
end)
