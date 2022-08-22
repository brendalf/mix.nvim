local stub = require("luassert.stub")

local config = require("mix.config")

describe("config", function ()
   it("should accept valid window opts", function ()
       assert.is_true(config.validate_config({
           window = "floating"
       }))

       assert.is_true(config.validate_config({
           window = "vertical"
       }))

       assert.is_true(config.validate_config({
           window = "horizontal"
       }))
   end)

   it("should failed when a unvalid window opt is passed", function ()
       assert.is_true(not config.validate_config({
           window = "different_window"
       }))
   end)


   it("should return default options when user options is empty", function ()
       local user_opts = config.get_config({})

       assert.equal(config.defaults.window, user_opts.window)
   end)

   it("should merge options", function ()
       local user_opts = config.get_config({
           window = "floating"
       })

       assert.equal("floating", user_opts.window)
   end)
end)
