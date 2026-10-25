" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" General {{{

nnoremap ; :

" Don't use Ex mode, use Q for formatting
xnoremap Q gq
nnoremap Q gqap

nmap <silent> <leader>/ :nohlsearch<CR>

vnoremap > >gv
vnoremap < <gv

inoremap <C-j> <C-o>J

map <F2> :set nu!<CR>
imap <F2> <C-O>:set nu!<CR>

cmap w!! w !sudo tee % >/dev/null

" }}}

" Searching {{{

" :Rg {pattern} [path...] searches and opens the quickfix window
command! -nargs=+ -complete=file Rg grep! <args> | cwindow
nnoremap <leader>* :grep! -w -- <C-R><C-W><CR>:cwindow<CR>

" }}}

" Registers and pasting {{{

nmap <leader>y "*y
nmap <leader>Y "*yy
nmap <leader>p "*p
nmap <leader>r :registers<CR>
nmap <leader>0 "0p
nmap <leader>1 "1p
nmap <leader>2 "2p
nmap <leader>3 "3p
nmap <leader>4 "4p
nmap <leader>5 "5p
nmap <leader>6 "6p
nmap <leader>7 "7p
nmap <leader>8 "8p
nmap <leader>9 "9p

" }}}

" Config, spelling and plugins {{{

nnoremap <leader>v :execute 'split' fnameescape(g:vimrc)<CR><C-W>_
nnoremap <silent> <leader>V :execute 'source' fnameescape(g:vimrc)<CR>:filetype detect<CR>:echo 'vimrc reloaded'<CR>

map <leader>s :setlocal spell! spelllang=pl<CR>
map <leader>S :setlocal spell! spelllang=en_US<CR>

nmap <silent> <leader>g :GundoToggle<CR>
nmap <silent> <leader>c :copen<CR>
nmap <silent> <leader>C :cclose<CR>
nmap <silent> <leader>m :make<CR>
nmap <silent> <leader>; :LustyJuggler<CR>

" }}}

" Tabs {{{

map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i

" }}}
