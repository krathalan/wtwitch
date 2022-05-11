let s:wtwitch_path = expand('<sfile>:p:h')

function! s:wtwitch_open_stream(line)
  let l:parser = split(a:line, ":")
  let l:stream = l:parser[0]
  silent execute '!' . s:wtwitch_path . '/../src/wtwitch w ' . l:stream
endfunction

command! -bang -nargs=0 WtwitchC
  \ call fzf#vim#grep(
  \   s:wtwitch_path . '/../src/wtwitch c', 0,
  \   {
  \     'sink': function('s:wtwitch_open_stream')
  \   },
  \   <bang>0
  \ )

"example usage
"nnoremap <space>T :WtwitchC<cr>
