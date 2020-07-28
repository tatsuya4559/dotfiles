setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

command! -buffer Outline :lvimgrep /^\s*\(private\|protected\|public\)/ % | lw
