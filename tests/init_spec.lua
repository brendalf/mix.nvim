local stub = require("luassert.stub")

local mix = require("mix")
local wrapper = require("mix.wrapper")
local window = require("mix.window")

describe("init", function()
    before_each(function()
        vim.g.mix_nvim_buffer = nil
    end)

    it("should setup plugin", function()
        local s_create_buf = stub(vim.api, "nvim_create_buf", 55)
        local s_nvim_set_buf_name = stub(vim.api, "nvim_buf_set_name")

        mix.setup()

        assert.equal(55, vim.g.mix_nvim_buffer)
        assert.stub(vim.api.nvim_create_buf).was_called()

        s_create_buf:revert()
        s_nvim_set_buf_name:revert()
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
        local s_run = stub(wrapper, "run", "output mocked\ntest")
        local s_nvim_buf_set_lines = stub(vim.api, "nvim_buf_set_lines")
        local s_open_floating_window = stub(window, "open_floating_window")

        vim.g.mix_nvim_buffer = 32
        mix.run({
            fargs = { "Mix", "deps.get" },
        })

        assert.stub(wrapper.run).was_called()
        assert.stub(vim.api.nvim_buf_set_lines).was_called()
        assert.stub(window.open_floating_window).was_called()

        s_open_floating_window:revert()
        s_run:revert()
        s_nvim_buf_set_lines:revert()
    end)
end)
