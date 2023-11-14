function! Eatchar() abort
  let char = nr2char(getchar())
  return (char == ' ' || char == "\t") ? '' : char
endfunction

nnoremap <Tab><Tab> ]`a

autocmd FileType sh inoreabbrev shebang. #!/bin/bash<CR><BS><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev bash. #!/bin/bash<CR><BS><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev #!. #!/bin/bash<CR><BS><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev read. read -r

autocmd FileType sh inoreabbrev echo. echo ""<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev echoerr. echo "" >&2<Esc>4hi<C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev if. if [[ z ]]; then<CR><Esc>mai<CR>fi<Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev el. else<CR><BS><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev ife. if [[ z ]]; then<CR><Esc>mai<CR>else<CR><Esc>mbi<CR>fi<Esc>mc?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev elif. elif [[ z]]; then<CR><Esc>ma?z<CR>xi<Left>

autocmd FileType sh inoreabbrev foreach. for item in <Esc>maa ; do<CR><Esc>mbi<CR>done <Esc>mci<Up><Up><C-R>=Eatchar()<CR><Esc>

autocmd FileType sh inoreabbrev fori. for ((i=1; i<z; i++)); do<CR><Esc>mai<CR>done <Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev while. while [[ z ]]; do<CR><Esc>mai<CR>done <Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev until. until [[ z ]]; do<CR><Esc>mai<CR>done <Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev br. break<C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev cont. continue<C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev e. exit

autocmd FileType sh inoreabbrev func. z ()<CR>{<CR><Esc>mai<CR>}<CR><Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>
 
autocmd FileType sh inoreabbrev void. z ()<CR>{<CR><Esc>mai<CR>}<CR><Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev function. z ()<CR>{<CR><Esc>mai<CR>}<CR><Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev readfile. while IFS= read -r line; do<CR>z<CR>done < <Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh inoreabbrev readf. while IFS= read -r line; do<CR>z<CR>done < <Esc>mb?z<CR>xa<Left><C-R>=Eatchar()<CR>

autocmd FileType sh au InsertLeave * if getline('.') =~ '.*#\s*=>$' | call EvaluateLine() | endif

function! EvaluateLine()
  let l:line_number = line('.')
  let l:line = getline(l:line_number)

  if l:line =~ '.*#\s*=>$'
    let [l:expression, l:comment] = split(l:line, '#\s*=>\s*', 1)

    let l:result = system(l:expression)

    let l:result_lines = split(l:result, '\n')

    for l:result_line in l:result_lines
      call append(l:line_number, '# ' . l:result_line)
      let l:line_number += 1
    endfor

    let l:last_comment_line = l:line_number
    let l:next_line = l:last_comment_line + 1
    call cursor(l:last_comment_line, col('$'))

    call append(l:next_line, '')
    call cursor(l:next_line + 1, col('$'))
    startinsert!
  endif
endfunction

autocmd FileType sh :terminal
