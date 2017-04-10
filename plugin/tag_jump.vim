" =============================================================================
" File: tag_jump.vim
" Description: A little plugin making tag jumping behave more like other IDE 
" Mantainer: Shih-Ming Wang (https://github.com/ipod825)
" Url: https://github.com/github.com/ipod825/TagJump
" License: MIT
" =============================================================================


nnoremap <C-]> :call PushTag()<CR>
nnoremap <C-t> :call PopTag()<CR>

fu! FindDup()
    let l:curTab = tabpagenr()
    let l:curBuf = bufnr('%')
    let l:dup = l:curTab
    for t in range(1, tabpagenr('$'))
        if t == l:curTab
            continue
        endif

        for buf in tabpagebuflist(t)
            if buf == curBuf
                let l:dup = t
            endif
        endfor
    endfor

    if l:dup != l:curTab
        return l:dup
    else
        return -1
    endif
endfu

fu! JumpAndClose(target)
    let l:curBuf = bufnr('%')
    let l:curTab = tabpagenr()
    exec "tabfirst"
    exec "tabnext ".a:target
    exec "tabclose ".l:curTab
endfu

fu! PushTag()
    execute "tag ".expand("<cword>")
    tab split
    tabp
    pop
    tabn
    let l:dup = FindDup()
    if l:dup >0
        let l:oldBuf = bufnr('%')
        let l:currentPos = getpos('.')
        call JumpAndClose(l:dup)
        while bufnr('%') != l:oldBuf
            wincmd w
        endwhile
        call setpos('.', l:currentPos)
    endif
endfu

fu! PopTag()
    pop
    let l:dup = FindDup()
    if l:dup >0
        call JumpAndClose(l:dup)
    endif
endfu
