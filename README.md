# mix-fugitive
Mix Fugitive is a Mix wrapper for Neovim.  
You can access any Mix commands with `:Mix` (or just `:M`).

> Currently we only support Neovim but we would like to have backwards compatibility with Vim Script in the future.

## Installation
Using [vim-plug](https://github.com/junegunn/vim-plug)
```viml
Plug 'brendalf/mix-fugitive'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { 'brendalf/mix-fugitive' }
```

## Setup
mix-fugitive needs to be initialized with the setup function.

For example:
```lua
require'mix-fugitive'.setup()
```

## Contributing
We welcome any kind of contribution.  
Please, look at the Issues page to see the current backlog, new suggestions, and bugs to work.

## License
Distributed under the same terms as Neovim itself.
