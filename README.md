# mix.nvim

A Mix (Elixir) wrapper for Neovim.

This plugin adds a `:Mix` (or just `:M`), which calls any arbitrary Mix command.

If you know how to use Mix at the command line, you know how to use `:Mix`.

It's vaguely akin to `:!mix` but with some improvements:
* Autocompletion for available Mix commands inside the current repository.
* Choose the type of window you want to show the output (WiP).
* Support Telescope integration to navigate through package's documentation (WiP).
* Run async commands inside Neovim (WiP).

![ezgif-1-ca42871cbc](https://user-images.githubusercontent.com/10671410/181785935-dee6da82-f1d2-4ced-a214-dcc202caba45.gif)

## Getting Started

This section should guide you to run your first Mix command with `:Mix`.

[Neovim 0.7](https://github.com/neovim/neovim/releases/tag/v0.7.0) or higher is required for `mix.nvim` to work.

### Recommended dependencies
* [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) to enable smooth auto completion.

### Installation
Using [packer.nvim](https://github.com/wbthomason/packer.nvim)
```lua
use { 'brendalf/mix.nvim', requires = { "nvim-lua/plenary.nvim" } }
```

Using [vim-plug](https://github.com/junegunn/vim-plug)
```viml
Plug 'nvim-lua/plenary.nvim'
Plug 'brendalf/mix.nvim'
```

Using [dein](https://github.com/Shougo/dein.vim)
```viml
call dein#add('nvim-lua/plenary.nvim')
call dein#add('brendalf/mix.nvim')
```

After installing, you need to initialize `mix.nvim` with the setup function.

For example:
```lua
require("mix").setup()
```

## Usage
The basic usage is `:Mix <command><cr>`.

Type `:Mix help` to see if `mix.nvim` is installed correctly.

If you have [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline) installed:
* Type `:Mix` and press `space` to see the available Mix commands (this could take a couple seconds in the first run).
* With the commands loaded you can start typing to get a smooth auto complete experience.

If you are using neovim (or lunarvim) without any cmd plugin:
* Type `:Mix`, press `space`, and then press `tab` to see the available Mix commands.
* Use `tab` to cycle through the commands or type the whole command wording.

As mentioned above, loading the list of commands in the first time can take some time, because `mix.nvim` is actually reading them from the output of `mix help`.

To enable a smooth experience, we save the list of commands internally after the initial loading.

To update the cache, you can call `:MixRefreshCompletions`.

## Contributing
All contributions are welcome! Just open a pull request.

Please look at the [Issues](https://github.com/brendalf/mix.nvim/issues) page to see the current backlog, suggestions, and bugs to work.

## License
Distributed under the same terms as Neovim itself.
