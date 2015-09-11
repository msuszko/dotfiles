if v:progname =~? "evim"
  finish
endif

set nocompatible

"NeoBundle Scripts-----------------------------
if has('vim_starting')

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" Add or remove your Bundles here:
NeoBundle 'gmarik/vundle'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'ludovicchabant/vim-lawrencium'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'sjbach/lusty'
NeoBundle 'sjl/gundo.vim.git'
"NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'ervandew/supertab'
NeoBundle 'Syntastic'
"NeoBundle 'Rykka/riv.vim'
"NeoBundle 'git://git.wincent.com/command-t.git'
NeoBundle 'rking/ag.vim'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

let mapleader = ","

set nobackup
set history=1000
set undolevels=1000      " use many muchos levels of undo
set viminfo=%,'500,\"1000,:1000,n~/.viminfo
set suffixes=.aux,.bak,.dvi,.gz,.idx,.log,.ps,.swp,.tar
set wildignore=*.swp,*.bak,*.pyc,*.class
set backspace=indent,eol,start

" search
set incsearch	  " do incremental searching
set hlsearch      " highlight search terms
set ignorecase    " ignore case when searching
set smartcase     " if searching and search contains upper case, make case sensitive search
nmap <silent> <leader>/ :nohlsearch<CR>

" Don't use Ex mode, use Q for formatting
map Q gq
nmap Q gqap

set background=light
set hidden

" indent
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set shiftwidth=4  " number of spaces to use for autoindenting
set tabstop=4     " a tab is four spaces

" display
set showmatch
set ruler		  " show the cursor position all the time
set showcmd		  " display incomplete commands
set visualbell    " don't beep
set noerrorbells  " don't beep

nnoremap ; :
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" pasting
set nopaste
set pastetoggle=<F10>
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
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo '.vimrc reloaded'"<CR>

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


set laststatus=2
set magic
set modeline
set modelines=1
set nonumber
set report=0
set ruler
set shortmess=atI
set showcmd
set showmode
set nostartofline
set notextmode
set textwidth=77
set ttyfast
set ttyscroll=0
set visualbell
set wildchar=<TAB>
set wrapmargin=1
set fileformat=unix
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,cp1250,iso8859-2
nnoremap <silent> <F8> :Tlist<Cr>

let g:tex_flavor = "context"

map <F2> :set nu!<CR>
imap <F2> <C-O>:set nu!<CR>

autocmd filetype python set expandtab
autocmd FileType text setlocal textwidth=78
autocmd FileType html,xhtml,xml,mako,jinja,htmljinja setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.xhtml setf xhtml
autocmd BufNewFile,BufRead *.mako setf mako
autocmd BufNewFile,BufRead *.jinja setf jinja
let html_no_rendering=1
let g:closetag_default_xml=1
autocmd FileType html,mako let b:closetag_html_style=1

"
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

vnoremap > >gv
vnoremap < <gv

inoremap <C-j> <C-o>J

map <F8> :new<CR>:read !hg diff<CR>:set syntax=diff buftype=nofile<CR>gg
map <F7> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg

au FileType python so ~/.vim/scripts/python.vim
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 

nmap <C-S-tab> :tabprevious<cr>
nmap <C-tab> :tabnext<cr>
map <C-S-tab> :tabprevious<cr>
map <C-tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
nmap <C-t> :tabnew<cr>
imap <C-t> <ESC>:tabnew<cr>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running")
    source ~/.vim/scripts/gui.vim
endif

if &t_Co > 2 || has("gui_running")
    set   t_Co=256
    syntax on
    set nohlsearch
    " colorscheme peeksea
endif

cmap w!! w !sudo tee % >/dev/null

filetype plugin indent on

