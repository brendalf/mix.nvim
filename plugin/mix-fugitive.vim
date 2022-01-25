fun! MixFugitive()
    lua for k in pairs(package.loaded) do if k:match("^mix%-fugitive") then package.loaded[k] = nil end end
    lua require("mix-fugitive").setup()
    "lua require("mix-fugitive").mix()
endfun

augroup MixFugitive
    autocmd!
augroup END
