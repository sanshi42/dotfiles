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
set incsearch  " 搜索时高亮
set hlsearch  " 高亮最近的匹配搜索模式

set ttyfast  " 指示一个快速的终端连接
set lazyredraw  " 仅仅必要的时候才重画 

set splitbelow  " 在当前窗口下打开新的窗口
set splitright  " 在当前窗口右打开新的窗口

set cursorline  " 高亮光标所在屏幕行
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
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
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
set updatecount=100  " 输入这么多个字符以后，把交换文件吸入磁盘。缺省为200，改为100

set undofile  " 把撤销信息写入一个文件里
set undodir=$HOME/.vim/files/undo//  " 撤销文件使用的目录名列表
