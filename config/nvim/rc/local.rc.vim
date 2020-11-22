let s:IMEManager = {
      \ 'is_japanese_mode': v:false
      \ }

function! s:IMEManager.toggle_japanese_mode() abort
  let self.is_japanese_mode = !self.is_japanese_mode
  if self.is_japanese_mode
    set statusline=日本語固定モード
  else
    set statusline=
  endif
endfunction

let s:FcitxManager = deepcopy(s:IMEManager)

function! s:FcitxManager.is_active() abort
    return system('fcitx-remote') == 2
endfunction

function! s:FcitxManager.activate() abort
  if !self.is_japanese_mode || self.is_active()
    return
  endif

  call system('fcitx-remote -o > /dev/null 2>&1')
endfunction

function! s:FcitxManager.deactivate() abort
  if self.is_active()
    call system('fcitx-remote -c > /dev/null 2>&1')
  endif
endfunction

let g:ime_manager = s:FcitxManager
augroup IMCtrl
  autocmd!
  autocmd InsertEnter * call g:ime_manager.activate()
  autocmd InsertLeave * call g:ime_manager.deactivate()
augroup END
command! ToggleKanaMode call g:ime_manager.toggle_japanese_mode()
nnoremap <Leader>k :ToggleKanaMode<CR>
