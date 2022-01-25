local mix = {}

function mix.help()
    local cmd = "mix --help"
    local result = vim.fn.system(cmd)
    print(result)
end

function mix.run()
   print("Hello")
end

return mix
