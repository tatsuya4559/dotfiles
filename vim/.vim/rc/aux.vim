vim9script

import './webutils.vim'

def Google(...words: list<string>): void
  if empty(words)
    return
  endif
  const q = join(words, '+')
  if q =~# '^https\?://'
    webutils.OpenUrl(q)
  else
    webutils.OpenUrl('https://www.google.com/search?q=' .. q)
  endif
enddef

command! -nargs=* Google Google(<f-args>)
nnoremap <silent> <leader>gg :Google <c-r><c-w><cr><cr>
vnoremap <silent> <leader>gg "zy:Google <c-r>z<cr>

command! -range AlignTable :<line1>,<line2>!pandoc -t gfm
