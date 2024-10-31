" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
" 设置帮助文档的语言为中文
set helplang=cn
" 打开文件类型检测，为特定的文件类型允许插件文件的载入和载入缩进文件
filetype plugin indent on
" Turn on syntax highlighting.
syntax on
set display=lastline " 显示窗口末行尽量多的内容 
set showmode  " 在命令行显示当前的mode，默认就是开启的
set showcmd  " 在最后一行显示命令 
" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" 修改全局变量，设置快捷键前缀<leader>从默认的\改为空格，此时<localleader>仍然为\
let g:mapleader = ' '
" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch  " 根据已在查找域中输入的文本，预览第一处匹配，搜索时高亮
set hlsearch  " 高亮最近的匹配搜索模式

set ttyfast  " 指示一个快速的终端连接
set lazyredraw  " 仅仅必要的时候才重画 

set splitbelow  " 在当前窗口下打开新的窗口
set splitright  " 在当前窗口右打开新的窗口

" set cursorline  "
" 高亮光标所在屏幕行（已弃用，后面设置了更加智能的，在插入模式中不要高亮）
set wrapscan  " 搜索在文件尾折回文件头

set report=0  " 总是报告行改变（行数下限为0）

set list  " 显示<Tab>和<EOL>

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
" nnoremap <Left>  :echoe "Use h"<CR>
" nnoremap <Right> :echoe "Use l"<CR>
" nnoremap <Up>    :echoe "Use k"<CR>
" nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
" inoremap <Left>  <ESC>:echoe "Use h"<CR>
" inoremap <Right> <ESC>:echoe "Use l"<CR>
" inoremap <Up>    <ESC>:echoe "Use k"<CR>
" inoremap <Down>  <ESC>:echoe "Use j"<CR>
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround  " 缩进取整到shiftwidth的倍数
" 安装code linting 插件ale
" 设置自动缩进
set autoindent
" 设置显示tab键，由于之前将tab键换成了4个空格，因此这里要输入则需要输入CTRL+v,<tab>
set listchars=tab:>-

" 打开文件时恢复光标位置
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" 临时文件管理设置（此时如果多个人修改同一个文件时，将不会警告）
" 如果文件夹不存在，则新建文件夹
"if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
"  call mkdir($HOME.'/.vim/files')
"endif

" 备份文件
" set backup
" set backupdir   =$HOME/.vim/files/backup/
" set backupext   =-vimbackup
" set backupskip  =
" 交换文件
" set directory   =$HOME/.vim/files/swap//
" set updatecount =100
" " 撤销文件
" set undofile
" set undodir     =$HOME/.vim/files/undo/
" viminfo 文件
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
" 启用内置的matchit插件
packadd! matchit
" 智能Ctrl-l：执行重新绘制
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" 禁用错误报警声音和图标
set noerrorbells
set novisualbell
set t_vb=
" 快速移动当前行
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
" 快速添加空行
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" 快速编辑（更改拼写错误）自定义宏
nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
" 使用 sudo 权限保存文件
cnoremap <slient> w!! w !sudo tee % > /dev/null
" 使用 %% 自动扩展为活动缓存区所在目录的路径
cnoremap <expr> %% getcmdtype() == ':' ? expand('%h').'/' : '%%'
" 在GUI中快速改变字体大小
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
" 根据模式改变光标类型（当前环境不一定有用，tmux中应该能用）
if empty($TMUX)
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  let &t_SR = "\<Esc>]50;CursorShape=2\x7"
else
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
endif
" 防止水平滑动的时候失去选择
xnoremap <  <gv
xnoremap >  >gv
" 选择当前行至结尾，排除换行符（给g_设置一个快捷键L）
nnoremap L g_
" ctags 的索引更新快捷键
nnoremap <f5> :!ctags -R<CR>
" 重新载入保存文件
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufWritePost ~/.Xdefaults call system('xrdb ~/.Xdefaults')
" 更加智能的当前行高亮
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline
" 更快的关键字补全
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags
" 改变颜色主题的默认外观
autocmd ColorScheme * highlight StatusLine ctermbg=darkgray cterm=NONE guibg=darkgray gui=NONE
" 配置Ruby文件的缩进和制表符设置（临时）
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 expandtab
" 显示最后一行的状态
set ruler
" 使用bash shell的方式自定义补全行为
" set wildmode=longest,list
" 使用zsh的方式自定义补全行为
set wildmenu
set wildmode=full
" 增加10倍的命令行保存历史上限
set history=200
" 安装vim中文文档的vim-plug，记得重启vim后执行:PlugInstall

" 查找当前选中文本的脚本
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
      let temp = @s
        norm! gv"sy
          let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
            let @s = temp
endfunction

" 自动化下载 plug.vim
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
      silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ###### 以下的配置来自于 ChatGPT 生成，请注意是否正确
" vim-plug 初始化
call plug#begin('~/.vim/plugged')

" 基础插件（暂时还不了解这些工具怎么使用，所以先全部注释掉
" Plug 'scrooloose/nerdtree'   " 文件浏览器
" Plug 'tpope/vim-fugitive'    " Git 集成
" Plug 'airblade/vim-gitgutter' " Git 差异显示
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'      " 模糊查找

" 结束插件块
call plug#end()
