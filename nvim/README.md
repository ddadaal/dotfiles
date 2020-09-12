# Neovim and vim conf

# Setting up 

Neovim config relies on the `.vimrc`, which should be put in `~/.vimrc`.

In my configuration, vim is used for simple editing whereas neovim is used like an IDE.

So my vim conf does not require any third-party plugins.

## Windows

```powershell
# PWD is .

# Setting vimrc by creating symbolic link
New-Item -ItemType SymbolicLink -Path $HOME -Name "_vimrc" -Target "$((Resolve-Path .vimrc).Path)"

# Set XDG_CONFIG_HOME to ~/.config for consistency with *nix
$XDG_CONFIG_HOME="$HOME\.config"
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", $XDG_CONFIG_HOME, [System.EnvironmentVariableTarget]::User)
$env:XDG_CONFIG_HOME = $XDG_CONFIG_HOME
New-Item -ItemType Directory -Force -Path $XDG_CONFIG_HOME

# Setting nvim configs by creating symbolic link
New-Item -ItemType SymbolicLink -Path $env:XDG_CONFIG_HOME -Name "nvim" -Target "$((Resolve-Path .\nvim).Path)"

# Install vim-plug for neovim
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim" -Force
```

## *nix

```bash
# PWD is .

# Setting vimrc by creating symbolic link
ln -s $(realpath .vimrc) ~/.vimrc

# Setting neovim config by symbolic link
ln -s $(realpath .) ~/.config/nvim 

# Install vim-plug for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```

# Snippets

Placeholders in ultisnips snippets do not work: cannot use `<tab>` to jump between placeholders.

# Font

[CaskaydiaCove NF](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode) is used. 

For Windows and scoop users, install it via

```
scoop bucket add nerd-fonts
scoop install CascadiaCode-NF
```

# Line break

Windows version of line break (\r\n) is used. 

For \*nix users,  install `dos2unix` to convert \r\n to \n.
