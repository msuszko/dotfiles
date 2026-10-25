
map <buffer> <leader><space> :w!<cr>:!python %<cr>

"Set some bindings up for 'compile' of python
setlocal makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
setlocal efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m

"setlocal omnifunc=RopeCompleteFunc

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal textwidth=79
setlocal expandtab
setlocal autoindent
setlocal fileformat=unix


"Python iMaps
setlocal cindent
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
vmap <buffer> <F7> :call Python_Eval_VSplit()<cr>
