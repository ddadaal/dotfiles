# Neovim conf

## Snippets

Place the snippets under coc-ultisnips to `~/.config/coc/ultisnips`

Note, placeholders in ultisnips snippets do not work: cannot use `<tab>` to jump between placeholders.

## Font

[CaskaydiaCove NF](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode) is used. 

For Windows and scoop users, install it via

```
scoop bucket add nerd-fonts
scoop install CascadiaCode-NF
```

## Line break

Windows version of line break (\r\n) is used. 

For \*nix users,  install `dos2unix` to convert \r\n to \n.
