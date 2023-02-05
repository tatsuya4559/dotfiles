vim9script

def NgGotoCompanionFile(): void
  const extension = expand('%:e') ==# 'ts' ? '.html' : '.ts'
  const filename = expand('%:p:r') .. extension
  if filereadable(filename)
    exe 'edit' filename
  else
    echom 'Cannot open ' .. filename
  endif
enddef
nnoremap <leader>t :<c-u>call <SID>NgGotoCompanionFile()<cr>
