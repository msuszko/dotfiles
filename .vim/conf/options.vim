" vim: fdm=marker ts=2 sts=2 sw=2 fdl=0

" General options{{{

set nocompatible
filetype plugin indent on

set encoding=utf-8

" Whitespaces and tabs
set tabstop=8 softtabstop=2 shiftwidth=2 expandtab
" Use shiftwidth for tab with at the BOL, and tabstop in other places
" Otherwise, tabstop is used always. Shiftwidth is only used for >>
set smarttab

" Let buffer be switched to another one without requiring to save it first
set hidden

" Timeout settings
" Wait forever until I recall mapping
" Don't wait to much for keycodes send by terminal, so there's no delay on <ESC>
set notimeout
set ttimeout
set timeoutlen=2000
set ttimeoutlen=30

" Zsh like <Tab> completion in command mode
set wildmenu
set wildmode=full

set mouse=

" Set <leader> key to <Space>
nnoremap <Space> <Nop>
let mapleader=" "
let maplocalleader=","

" <Backspace> in Insert mode
set backspace=indent,eol,start

" Keep some characters visible during horizontal scroll
" Recenter cursor during horizontal scroll
set sidescroll=0
set sidescrolloff=3

" Minimal number of screen lines to keep above and below the cursor, expect for bol and eol
set scrolloff=2

" Status line
" Always show status line, even when 1 window is opened
set laststatus=2

" Highlight the line with a cursor
set cursorline

" Show cursorline in current window and not in insert mode
augroup aug_cursor_line
  au!
  au InsertEnter * setlocal nocursorline
  au InsertLeave * setlocal cursorline
augroup END

" Disable reading vim variables & options from special comments within file header or footer
set modeline
set modelines=1

" Display uncompleted commands in the status line
set showcmd

" Show ruler
set ruler

" Use /g flag for substitute command by default
set gdefault

" Tweak autocompletion behavior for <C-n>/<C-p> in insert mode
" Default is ".,w,b,u,t,i" without "i", where:
" . - scan current buffer. Same to invoking <C-x><C-n> individually
" w - buffers in other windows
" b - loaded buffers in buffer list
" u - unloaded buffers in buffer list
" t - tags. Same to invoking <C-x><C-]> individually
" i - included files. We don't need this.
" kspell, when spell check is active, use words from spellfiles
set complete-=i
set complete+=kspell


" Add @@@ marks on the last column of last line if there is more text below
set display=lastline

" Auto indentation
set autoindent
set smartindent
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'

" Disable startup message
set shortmess+=I

" Conceal text and highlight with "Conceal" highlight group
set conceallevel=2

" }}}
