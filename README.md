# mix.nvim
Mix.nvim is a Mix wrapper for Neovim.

You can access any Mix commands with `:Mix` (or just `:M`).


![ezgif-1-ca42871cbc](https://user-images.githubusercontent.com/10671410/181785935-dee6da82-f1d2-4ced-a214-dcc202caba45.gif)


## Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { 'brendalf/mix.nvim' }
```

Using [vim-plug](https://github.com/junegunn/vim-plug)
```viml
Plug 'brendalf/mix.nvim'
```

## Setup
mix.nvim needs to be initialized with the setup function.

For example:
```lua
require("mix").setup()
```

## How to use
If you type `:Mix` and press space, the plugin will automatically load the available Mix commands for you.

Mix.nvim uses a cache to avoid calling the system every time.

You can find the command you want to execute and press enter `<CR>`.

## Contributing
We welcome any kind of contribution.

Please, look at the Issues page to see the current backlog, new suggestions, and bugs to work.

## License
Distributed under the same terms as Neovim itself.
