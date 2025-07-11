if exists('g:loaded_buffer_marks')
  finish
endif
let g:loaded_buffer_marks = 1

" Dictionary to store marks (char => bufnr)
let s:buffer_marks = {}

" Function to mark current buffer
function! s:MarkBuffer(char) abort
  let s:buffer_marks[a:char] = bufnr('%')
  echo "buffer_marks: buffer marked as '" . a:char . "'"
endfunction

" Function to jump to marked buffer
function! s:JumpToMarkedBuffer(char) abort
  let l:buf = get(s:buffer_marks, a:char, -1)
  if bufexists(l:buf)
    execute 'buffer' l:buf
  else
    echo "buffer_marks: No buffer marked as '" . a:char . "'"
  endif
endfunction

function! s:PromptAndHandle(mode) abort
    let l:char = nr2char(getchar())
    if a:mode ==# 'mark'
        call s:MarkBuffer(l:char)
    else
        call s:JumpToMarkedBuffer(l:char)
    endif
endfunction

command! -nargs=0 Mark call <SID>PromptAndHandle('mark')
command! -nargs=0 GoToMark call <SID>PromptAndHandle('goto_mark')
