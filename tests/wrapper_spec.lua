local stub = require("luassert.stub")

local wrapper = require("mix.wrapper")
local exs = require("mix.exs")

local cwd = vim.fn.fnamemodify(nil, ":p:h") .. "/tests"

describe("wrapper", function()
    before_each(function()
        vim.g.mix_complete_list = nil
        exs.mix_exs_path_cache = nil
    end)

    it("should update completions in cache", function()
        wrapper.refresh_completions()

        local completions_len = #vim.g.mix_complete_list

        assert.is_true(completions_len > 0)
    end)

    it("should load completions when not cached", function()
        local s = stub(wrapper, "refresh_completions")

        assert.is_nil(vim.g.mix_complete_list)

        wrapper.load_completions("test")

        assert.stub(wrapper.refresh_completions).was_called()

        s:revert()
    end)

    it("should return cached completions", function()
        local s = stub(wrapper, "refresh_completions")

        vim.g.mix_complete_list = "test1\ntest2\n"

        wrapper.load_completions("test")

        assert.stub(wrapper.refresh_completions).was_not_called()

        s:revert()
    end)

    it("should run mix commands successfully", function()
        local s = stub(wrapper, "mix_exs", cwd .. "/mock")
        local output = wrapper.run("deps.get", {})

        assert.equal("All dependencies are up to date\n", output)
        s:revert()
    end)

    it("should resolve mix.exs path when not cached", function()
        local s = stub(exs, "path_mix_exs", {
            mix_file = cwd .. "/mock/mix.exs",
            mix_dir = cwd .. "/mock",
            file_exists = true,
        })

        local path = wrapper.mix_exs()

        assert.equal(cwd .. "/mock", path)
        assert.equal(cwd .. "/mock", wrapper.mix_exs_path_cache)
        assert.stub(exs.path_mix_exs).was_called()

        s:revert()
    end)

    it("should return cached mix.exs file path", function()
        local s = stub(exs, "path_mix_exs", {
            mix_file = cwd .. "/mock/mix.exs",
            mix_dir = cwd .. "/mock",
            file_exists = true,
        })

        exs.mix_exs_path_cache = cwd .. "/mock"
        local path = wrapper.mix_exs()

        assert.equal(cwd .. "/mock", path)
        assert.equal(cwd .. "/mock", wrapper.mix_exs_path_cache)
        assert.stub(exs.path_mix_exs).was_not_called()

        s:revert()
    end)
end)
