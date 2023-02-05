vim9script

export def OpenUrl(url: string): void
  # I don't have windows
  const openprg = has('mac') ? 'open' : 'xdg-open'
  system(printf('%s %s', openprg, shellescape(url)))
enddef
