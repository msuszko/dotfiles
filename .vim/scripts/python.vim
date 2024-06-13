
map <buffer> <leader><space> :w!<cr>:!python %<cr>

"Set some bindings up for 'compile' of python
set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"setlocal omnifunc=RopeCompleteFunc

set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set fileformat=unix


"Python iMaps
set cindent
inoremap <buffer> $r return
inoremap <buffer> $s self
inoremap <buffer> $c ##<cr>#<space><cr>#<esc>kla
inoremap <buffer> $i import
inoremap <buffer> $p print
inoremap <buffer> $d """<cr>"""<esc>O

"Run in the Python interpreter
function! Python_Eval_VSplit() range
  let src = tempname()
  let dst = tempname()
  execute ": " . a:firstline . "," . a:lastline . "w " . src
  execute ":!python " . src . " > " . dst
  execute ":pedit! " . dst
endfunction
vmap <F7> :call Python_Eval_VSplit()<cr>
