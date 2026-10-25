" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

let g:gitgutter_enabled = 1
let g:ale_sign_error = '☢'
let g:ale_sign_warning = '☹'
" highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:airline#extensions#ale#enabled = 1
let g:airline_theme='papercolor'
let g:ale_linters = {'python': ['flake8']}

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

nnoremap <leader>* :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>


set nobackup
set history=1000
set undolevels=1000      " use many muchos levels of undo
if has('nvim')
  set viminfo=%,'500,\"1000,:1000,n~/.vim/nviminfo
else
  set viminfo=%,'500,\"1000,:1000,n~/.vim/viminfo
endif
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar
set wildignore=*.swp,*.bak,*.pyc,*.class

" search
set incsearch	  " do incremental searching
set hlsearch      " highlight search terms
set ignorecase    " ignore case when searching
set smartcase     " if searching and search contains upper case, make case sensitive search
nmap <silent> <leader>/ :nohlsearch<CR>

" Don't use Ex mode, use Q for formatting
xnoremap Q gq
nnoremap Q gqap

set background=light
set hidden


" display
set showmatch
set showcmd       " display incomplete commands
set visualbell    " don't beep
set noerrorbells  " don't beep

nnoremap ; :
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" pasting
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

" .vimrc
nnoremap <leader>v :execute 'split' fnameescape(g:vimrc)<CR><C-W>_
nnoremap <silent> <leader>V :execute 'source' fnameescape(g:vimrc)<CR>:filetype detect<CR>:echo 'vimrc reloaded'<CR>

" spelling
set spellfile=~/.vim/spell.add
map <leader>s :setlocal spell! spelllang=pl<CR>
map <leader>S :setlocal spell! spelllang=en_US<CR>

nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>g :GundoToggle<CR>
nmap <silent> <leader>c :copen<CR>
nmap <silent> <leader>C :cclose<CR>
nmap <silent> <leader>m :make<CR>
nmap <silent> <leader>; :LustyJuggler<CR>


set magic
set nonumber
set report=0
set ruler
set showmode
set nostartofline
set textwidth=78
" set colorcolumn=78
set ttyfast
set visualbell
set wildchar=<TAB>
set wrapmargin=1
set fileformat=unix
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,cp1250,iso8859-2

let g:tex_flavor = "latex"

map <F2> :set nu!<CR>
imap <F2> <C-O>:set nu!<CR>

" Nessus:
let nasl_space_errors = 1

let html_no_rendering=1
let g:closetag_default_xml=1

augroup aug_filetypes
  autocmd!
  autocmd FileType text setlocal textwidth=78
  autocmd FileType xml setlocal noexpandtab tabstop=2
  autocmd BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.xhtml setf xhtml
  autocmd BufNewFile,BufRead *.mako setf mako
  autocmd BufNewFile,BufRead *.jinja setf jinja
  autocmd BufNewFile,BufRead *.audit set syntax=xml
  autocmd BufNewFile,BufRead *.nasl set filetype=nasl
  autocmd BufNewFile,BufRead *.inc set filetype=nasl
  autocmd BufNewFile,BufRead *.inc set indentexpr=
  autocmd FileType markdown setlocal spell
  autocmd FileType gitcommit setlocal spell
  autocmd FileType html,mako let b:closetag_html_style=1
  autocmd FileType python source ~/.vim/scripts/python.vim
augroup END

"
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

vnoremap > >gv
vnoremap < <gv

inoremap <C-j> <C-o>J

map <F8> :new<CR>:read !hg diff<CR>:set syntax=diff buftype=nofile<CR>gg
map <F7> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg

map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running")
    source ~/.vim/scripts/gui.vim
endif

if &t_Co > 2 || has("gui_running")
    set   t_Co=256
    syntax on
    "let g:seoul256_light_background = 250
    colorscheme lucius
endif
if &term == "screen"
  set t_Co=256
endif

cmap w!! w !sudo tee % >/dev/null

filetype plugin indent on
