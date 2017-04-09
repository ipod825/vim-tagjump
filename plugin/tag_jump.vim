" =============================================================================
" File: tag_jump.vim
" Description: A little plugin making tag jumping behave more like other IDE 
" Mantainer: Shih-Ming Wang (https://github.com/ipod825)
" Url: https://github.com/github.com/ipod825/TagJump
" License: MIT
" =============================================================================

nnoremap <C-]> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <C-t> <C-t>:call JumpIfDup()<CR>

fu! JumpIfDup()
    let l:currentTabNr = tabpagenr()
    let l:currentBufNr = bufnr('%')
    let l:target = l:currentTabNr
    for t in range(1, tabpagenr('$'))
        if t == currentTabNr
            continue
        endif

        for buf in tabpagebuflist(t)
            if buf == currentBufNr
                let l:target = t
            endif
        endfor
    endfor

    if l:target != l:currentTabNr
        exec "tabfirst"
        exec "tabnext ".l:target
        exec "tabclose ".l:currentTabNr
    endif
endfu
