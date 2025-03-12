" Breaks a line of text into multiple lines with a maximum length
function! s:break_line(text, length)
    let old_cpo = &cpo
    set cpo&vim

    " Split the text into words and store them in an array
    let words = split(a:text)

    " Initialize variables to track the current line and its length
    let current_line = ''
    let current_length = 0

    " Iterate over each word
    for word in words
        " If adding this word would exceed the limit, start a new line
        if strlen(word) > a:length || (current_length + strlen(word)) > a:length
            call add(current_line, '\r')
            let current_length = 0
        endif

        " Add the word to the current line
        let current_line .= word . ' '
        let current_length += strlen(word)
    endfor

    " Remove trailing whitespace and return the formatted text
    return trim(current_line)

endfunction

augroup LL
    autocmd!
    autocmd VimEnter * call LL#init()
    autocmd VimEnter * call break_lines#init()
augroup END
" Add a command to format the text
command! -nargs=1 -range LL call <SID>break_line(<line1>, <line2>, <q-args>)
