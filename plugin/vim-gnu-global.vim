" =============================================================================
"      FileName: vim-gnu-global.vim
"          Desc: vim plug for gnu global
"        Author: loseblue
"         Email: loseblue[a]163.com
"      HomePage: http://loseblue.farbox.com/
"       Version: 0.0.1
"    LastChange: 2015-01-05 12:29:35
"       History:
" =============================================================================

if exists("loaded_gnu_global")
    finish
endif
if (v:progname == "ex")
    finish
endif
let loaded_gnu_global = 1

let s:savedCpo = &cpo
set cpo&vim

let s:running_windows = has("win16") || has("win32") || has("win64")

au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! VimEnterCallback()
    for f in argv()
        if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
            continue
        endif

        call FindGtags(f)
    endfor
endfunc

if s:running_windows
    function! FindGtags(f)
        let dir = fnamemodify(a:f, ':p:h')
        let backup = 0
        while 1
            let tmp = dir . '/GTAGS'
            if filereadable(tmp)
                exe 'cs add ' . tmp . ' ' . dir
                break
            elseif backup == tmp
                break
            endif
            backup = tmp

            let dir = fnamemodify(dir, ":h")
        endwhile
    endfunc
else
    function! FindGtags(f)
        let dir = fnamemodify(a:f, ':p:h')
        while 1
            let tmp = dir . '\GTAGS'
            if filereadable(tmp)
                exe 'cs add ' . tmp . ' ' . dir
                break
            elseif dir == '/'
                break
            endif

            let dir = fnamemodify(dir, ":h")
        endwhile
    endfunc
endif

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' . dir . ' && global -u &> /dev/null &'
endfunction

" function! UpdateGtags()
"     call xolox#misc#os#exec({'command': 'global -u', 'async': 1})
" endfunction

let &cpo = s:savedCpo
