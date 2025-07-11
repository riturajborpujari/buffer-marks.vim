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

let s:marks_list_popup_id = -1

function! s:ShowMarksListPopup()
  let lines = [' Mark  │ Buffer']
  call add(lines, '───────┼────────────────────────')

  for [key, bufnr] in items(s:buffer_marks)
    let bufname = fnamemodify(bufname(bufnr), ':t')
    let line = printf('  %-4s │ %s', key, bufname)
    call add(lines, line)
  endfor

  let s:marks_list_popup_id = popup_create(lines, #{
        \ line: &lines / 2 - 4,
        \ col: &columns / 2 - (&columns/2) / 2 - 2,
        \ pos: 'topleft',
        \ padding: [1,1,1,1],
        \ minwidth: &columns / 2 - 2,
        \ highlight: 'Pmenu',
        \ border: [0,0,0,0],
        \ borderhighlight: ['Pmenu'],
        \ })
endfunction

function! s:MarksListToggle() 
    if s:marks_list_popup_id != -1
        call popup_close(s:marks_list_popup_id)
        let s:marks_list_popup_id = -1
    else
        call <SID>ShowMarksListPopup()
    endif
endfunction

command! -nargs=0 Mark call <SID>PromptAndHandle('mark')
command! -nargs=0 GoToMark call <SID>PromptAndHandle('goto_mark')
command! -nargs=0 MarksListToggle call <SID>MarksListToggle()
