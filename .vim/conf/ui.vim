" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" airline {{{
let g:airline_theme='lucius'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" }}}

" colours {{{
set background=light

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
    syntax on
    colorscheme lucius
endif
" }}}
