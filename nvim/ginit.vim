nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
nnoremap <silent> <C-+> :set guifont=+<CR>
nnoremap <silent> <C-_> :set guifont=-<CR>

if exists("g:GuiLoaded")
	call GuiClipboard()
	GuiFont! Cascadia Code PL:h16
	GuiTabline 0
	GuiPopupmenu 0
	call GuiWindowMaximized(1)
endif

if exists("g:fvim_loaded")
    nnoremap <F11> :FVimToggleFullScreen<CR>
    FVimCustomTitleBar v:true
    FVimUIPopupMenu v:false
endif
