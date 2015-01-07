# vim-global-project

## About
vim use GNU global as project

## Installation
1. Install using [Pathogen], [Vundle], [Neobundle], or your favorite Vim package manager.

2. add code in vimrc
```
command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
function! FindFiles(pat, ...)
    let path = ''
    for str in a:000
        let path .= str . ','
    endfor

    if path == ''
        let path = &path
    endif

    echo 'finding...'
    redraw
    call append(line('$'), split(globpath(path, a:pat), '\n'))
    echo 'finding...done!'
    redraw
endfunc
```

## Quick Start

```
map <F8> :e gtags.files<CR>:FindFiles **/*.[chs] 
```

1. press `F8` to create gtags.files and add files and floders.
2. add floders at your wish.
3. press `<CR>`

## Function

## Related
[GNU GLOBAL Source Code Tag System]:http://www.gnu.org/software/global/manual/global.html
[介绍一下gnu global，比cscope更方便更快速的索引工具]:http://forum.ubuntu.org.cn/viewtopic.php?t=343460
[Pathogen]:http://github.com/tpope/vim-pathogen
[Vundle]:http://github.com/gmarik/vundle
[Neobundle]:http://github.com/Shougo/neobundle.vim
