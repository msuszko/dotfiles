" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

let g:tex_flavor = "latex"
let html_no_rendering=1

" Nessus:
let nasl_space_errors = 1

augroup aug_filetypes
  autocmd!
  autocmd FileType text,markdown,gitcommit setlocal textwidth=78
  autocmd FileType xml setlocal noexpandtab tabstop=2
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead *.xhtml setf xhtml
  autocmd BufNewFile,BufRead *.mako setf mako
  autocmd BufNewFile,BufRead *.jinja setf jinja
  autocmd BufNewFile,BufRead *.audit set syntax=xml
  autocmd BufNewFile,BufRead *.nasl set filetype=nasl
  autocmd BufNewFile,BufRead *.inc set filetype=nasl
  autocmd BufNewFile,BufRead *.inc set indentexpr=
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType python source ~/.vim/scripts/python.vim
augroup END

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
augroup aug_last_position
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END
