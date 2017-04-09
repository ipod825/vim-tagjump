" =============================================================================
" File: tag_jump.vim
" Description: A little plugin making tag jumping behave more like other IDE 
" Mantainer: Shih-Ming Wang (https://github.com/ipod825)
" Url: https://github.com/github.com/ipod825/TagJump
" License: MIT
" =============================================================================

nnoremap <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>:call CleanDup()<CR>
nnoremap <C-t> <C-t>:call JumpIfDup()<CR>

fu! FindDup()
    let l:currentTabNr = tabpagenr()
    let l:currentBufNr = bufnr('%')
    let l:dup = l:currentTabNr
    for t in range(1, tabpagenr('$'))
        if t == currentTabNr
            continue
        endif

        for buf in tabpagebuflist(t)
            if buf == currentBufNr
                let l:dup = t
            endif
        endfor
    endfor

    if l:dup != l:currentTabNr
        return l:dup
    else
        return -1
    endif
endfu

fu! CleanDup()
    let l:dup = FindDup()
    if l:dup>0
        exec "tabclose ".l:dup
    endif
endfu

fu! JumpIfDup()
    let l:dup = FindDup()
    if l:dup >0
        let l:currentBufNr = bufnr('%')
        let l:currentTabNr = tabpagenr()
        exec "tabfirst"
        exec "tabnext ".l:dup
        exec "tabclose ".l:currentTabNr
    endif
endfu
