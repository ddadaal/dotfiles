# Dotfiles

This is my dotfiles and configuration scripts.

## Includes

- [neovim](nvim)
  - [init.vim](nvim/init.vim) 
  - [ginit.vim](nvim/ginit.vim)
  - [Windows Context Menu Registration](nvim/nvim.reg)
  - [.vimrc](nvim/.vimcrc) for general vim configuration (simple)
- [.doom.d](.doom.d)
  - [Doom Emacs](https://github.com/hlissner/doom-emacs) configs
- Jetbrains vim rc
  - [.vimrc](.vimrc) simple general vim configuration and for VsVim
  - [.ideavimrc](.ideavimrc) (relies on .vimrc)
- i3
  - [i3config](i3config)
  - [i3statusconfig](i3statusconfig)
  - [init script](init-i3.sh)
- Zsh
  - [.zshrc](.zshrc)
  - [init script](init-zsh.sh)
- URxvt
  - [.Xresources](.Xresources)
- yay
  - [init script](init-yay.sh)
- Arch mainly used in WSL
  - [init script](init-arch.sh)
    - `curl https://raw.githubusercontent.com/ddadaal/dotfiles/master/init-arch.sh | bash`
- Windows Terminal
  - [Windows Context Menu Registration](wt/wt.reg)
  - Need to change the default profile's startingDirectory to `.`

## Tips

Change all files to end with \n instead of \r\n when the repo is cloned from Windows
