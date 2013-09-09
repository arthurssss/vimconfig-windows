"-------------------------------------------------------------------------------
" Maintainer:   wangweipeng <arthursssssss@gmail.com>
" DesCRiption:  vimrc for Windows/Linux/Mac
" Last Change:  2013/9/4
" Author:       wangweipeng <arthursssssss@gmail.com>
" Version:      1.0
"-------------------------------------------------------------------------------

function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "win"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

set nocompatible                    " 关闭 vi 兼容模式

if MySys()=="unix"                  " 自动语法高亮
    if v:version<600
        if filereadable(expand("$VIM/syntax/syntax.vim"))
            syntax on
        endif
    else
        syntax on
    endif
else
    syntax on
endif

filetype on                         " 检测文件类型
if has("eval") && v:version>=600
    filetype plugin indent on       " 开启插件
endif

"-------------------------------------------------------------------------------
" 界面
"-------------------------------------------------------------------------------
if has("gui_running")
    set guioptions-=m " 隐藏菜单栏
    set guioptions+=T " 隐藏工具栏
    set guioptions+=L " 隐藏左侧滚动条
    set guioptions+=r " 隐藏右侧滚动条
    set guioptions+=b " 隐藏底部滚动条
    set showtabline=2 " 隐藏Tab栏

    if MySys()=="win"
        if has("autocmd")
            au GUIEnter * simalt ~x         " 最大化
        endif
    endif
    if v:version > 601
        colorscheme desert                  " 设定配色方案
    endif
else
    if v:version > 601
        colorscheme desert                  " 设定配色方案
    endif
endif
"-------------------------------------------------------------------------------

if MySys() == "unix" || MySys() == "mac"
    set shell=bash
endif
" 文件在其他程序修改后，vim自动载入最新文件
if exists("&autoread")
    set autoread
endif
" 设置鼠标可用
if exists("&mouse")
    set mouse=a
endif
set shortmess=atl                   " 启动时不显示捐助提示
set number                          " 显示行号
set nowrap                          " 不自动换行
set ruler                           " 打开状态栏标尺
set shiftwidth=4                    " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4                   " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4                       " 设定 tab 长度为 4
set expandtab                       " 用 space 替代 tab 的输入
set nobackup                        " 覆盖文件时不备份
set noswapfile                      " 禁止生成临时文件
set autochdir                       " 自动切换当前目录为当前文件所在的目录
set backupcopy=yes                  " 设置备份时的行为为覆盖
set ignorecase smartcase            " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan                      " 禁止在搜索到文件两端时重新搜索
"set incsearch                       " 输入搜索内容时就显示搜索结果
set hlsearch                        " 搜索时高亮显示被找到的文本
set noerrorbells                    " 关闭错误信息响铃
set novisualbell                    " 关闭使用可视响铃代替呼叫
set t_vb=                           " 置空错误铃声的终端代码
"set showmatch                       " 插入括号时，短暂地跳转到匹配的对应括号
"set matchtime=2                     " 短暂跳转到匹配括号的时间
set magic                           " 设置魔术
set hidden                          " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
"set smartindent                     " 开启新行时使用智能自动缩进
set backspace=indent,eol,start      " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1                     " 设定命令行的行数为 1
set history=1024                    " 命令历史条数
set scrolloff=2                     " 上下可视行数
set whichwrap+=<,>                  " 按左右键时如果到了行首（行尾）可以继续到上一行（下一行）

if v:version>=700
    set switchbuf=usetab
endif

" 显示Tab符
set list listchars=tab:>-,trail:_,extends:>,precedes:<
hi NonText ctermfg=255 guifg=#888888
hi SpecialKey ctermfg=255 guifg=#555555

" 突出显示当前行
if has("gui_running")
    if exists("&cursorline")
        set cursorline
    endif
endif

"-------------------------------------------------------------------------------
" 设置在状态行显示的信息
"-------------------------------------------------------------------------------
set laststatus=2                    " 显示状态栏 (默认值为 1, 无法显示状态栏)
set statusline=\ %<%F[%n]           " 完整文件名
set statusline+=%h%r%w%1*%m%*       " 状态
set statusline+=%=                  " 分隔符
set statusline+=[%{strlen(&ft)?&ft:''}  " 文件类型
set statusline+=%{strlen(&ft)?',':''}
set statusline+=%{strlen(&fileencoding)?&fileencoding:''}   " 文件编码
set statusline+=%{strlen(&fileencoding)?',':''}
set statusline+=%{&fileformat}]     " file format
set statusline+=[0x%02B]            " current char
set statusline+=[%l,%c/%L][%P]\     " offset
"-------------------------------------------------------------------------------
if has('title') && (has('gui_running') || &title)
    set titlestring=
    set titlestring+=%f\ (%F)       " file name
    set titlestring+=%h%r%w%m   " flags
    set titlestring+=\ -\ %{v:progname} " program name
endif

"-------------------------------------------------------------------------------
" 设置语法折叠
"-------------------------------------------------------------------------------
set foldenable                      " 开始折叠
set foldmethod=syntax               " 设置语法折叠
set foldcolumn=0                    " 设置折叠区域的宽度
set foldlevelstart=99               " 关闭语法折叠
setlocal foldlevel=1                " 设置折叠层数为
"set foldclose=all                   " 设置为自动关闭折叠
"-------------------------------------------------------------------------------



" 用户目录变量$VIMFILES
if MySys() == "win"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "unix" || MySys() == "mac"
    let $VIMFILES = $HOME.'/.vim'
endif

" 设定doc文档目录
let helptags=$VIMFILES.'/doc'

"-------------------------------------------------------------------------------
" 设置多语言
"-------------------------------------------------------------------------------
if has("multi_byte")
    set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, untested
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
endif

if exists("&ambiwidth")
    set ambiwidth=double
endif
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" 按键绑定
"-------------------------------------------------------------------------------
" 搜索选中字符
vnoremap <silent> <a-f> y/<c-r>=escape(@", "\\/.*$^~[]")<cr><cr>

" 搜索剪切板中的字符
nmap <a-f> /<c-r>=escape(@+, "\\/.*$^~[]")<cr><cr>
imap <a-f> <esc>/<c-r>=escape(@+, "\\/.*$^~[]")<cr><cr>

" 删除所有行未尾空格
nnoremap <f12> :%s/\s\+$//g<cr>

" 设置换行符
set ffs=unix,dos,mac
" 转换成dos换行符
nmap <leader>fd :e ++ff=dos<cr>
" 转换成unix换行符
nmap <leader>fu :e ++ff=unix<cr>

" 保存
nmap <a-s> :wa<cr>
imap <a-s> <esc>:wa<cr>
nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>

" 在系统支持 wildmenu 特性启用文本模式的菜单
if has('wildmenu')
    set wildmenu    "打开 wildmenu 选项，启动具有菜单项提示的命令行自动完成。
endif

inoremap " ""<esc>i
if has("autocmd")
    autocmd BufNewFile,BufRead *.vim inoremap " "
endif
inoremap ' ''<esc>i
inoremap ( ()<esc>i
inoremap [ []<esc>i
inoremap { {}<esc>i

nmap <leader>hex :%!xxd<cr>
nmap <leader>dec :%!xxd -r<cr>

" tab页面
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" buffer切换
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

"复制粘贴
vnoremap <c-x> "+x
vnoremap <c-c> "+y
map <c-v> "+gp
imap <c-v> <esc><c-v>i
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

map Y y$

" 用tab键缩进
nmap <TAB> >>
vmap <TAB> >

" 用backspace取消缩进
nmap <BACKSPACE> <<
vmap <BACKSPACE> <

" 空格键实现缩进一格
nmap <space> I <esc>
vmap <space> I <esc>

imap <c-l> <c-x><c-l>
noremap <a-a> <c-a>
nmap <f2> za
nmap <c-a> ggVG

iabbrev xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

if has("eval") && has("autocmd")
    "c/cpp
    fun! Abbrev_cpp()
        ia <buffer> cci const_iterator
        ia <buffer> ccl cla
        ia <buffer> cco const
        ia <buffer> cdb bug
        ia <buffer> cde throw
        ia <buffer> cdf /** file<CR><CR>/<Up>
        ia <buffer> cdg ingroup
        ia <buffer> cdn /** Namespace <namespace<CR><CR>/<Up>
        ia <buffer> cdp param
        ia <buffer> cdt test
        ia <buffer> cdx /**<CR><CR>/<Up>
        ia <buffer> cit iterator
        ia <buffer> cns Namespace ianamespace
        ia <buffer> cpr protected
        ia <buffer> cpu public
        ia <buffer> cpv private
        ia <buffer> csl std::list
        ia <buffer> csm std::map
        ia <buffer> css std::string
        ia <buffer> csv std::vector
        ia <buffer> cty typedef
        ia <buffer> cun using Namespace ianamespace
        ia <buffer> cvi virtual
        ia <buffer> #i #include
        ia <buffer> #d #define
    endfunction

    fun! Abbrev_java()
        ia <buffer> #i import
        ia <buffer> #p System.out.println
        ia <buffer> #m public static void main(String[] args)
    endfunction

    fun! Abbrev_python()
        ia <buffer> #i import
        ia <buffer> #p print
        ia <buffer> #m if __name__=="__main__":
    endfunction

    fun! Abbrev_aspvbs()
        ia <buffer> #r Response.Write
        ia <buffer> #q Request.QueryString
        ia <buffer> #f Request.Form
    endfunction

    fun! Abbrev_js()
        ia <buffer> #a if(!0){throw Error(callStackInfo());}
    endfunction

    fun! Abbrev_lua()
        ia if if then<cr>end<up><left>
        ia for for do<cr>end<up><left>
        ia lcoal local
    endfunction
    augroup abbreviation
        au!
"        au FileType javascript :call Abbrev_js()
"        au FileType cpp,c :call Abbrev_cpp()
"        au FileType java :call Abbrev_java()
"        au FileType python :call Abbrev_python()
"        au FileType aspvbs :call Abbrev_aspvbs()
        au FileType lua :call Abbrev_lua()
    augroup END
endif

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" 创建一个临时文件
map <leader>q :e ~/buffer<cr>



"===============================================================================
" DesCRiption: 插件
"===============================================================================

"-----------------------------------------------------------------
" plugin - winManager.vim 窗口管理
"-----------------------------------------------------------------
if filereadable(expand("$VIMFILES/plugin/winmanager.vim"))
    let g:winManagerWidth = 30 
    let g:defaultExplorer = 0
    let g:NERDTree_title='NERD Tree'
    let g:winManagerWindowLayout='NERDTree|BufExplorer'

    function! NERDTree_Start()
        exec 'NERDTree'
    endfunction
    function! NERDTree_IsValid()
        return 1
    endfunction

    nmap <F3> :WMToggle<cr>
    imap <F3> <ESC>:WMToggle<CR>
    au VimEnter * WMToggle
"    au VimEnter * q
endif

"-----------------------------------------------------------------
" plugin - BufExplorer.vim Buffers切换
" \be 全屏方式查看全部打开的文件列表
" \bv 左右方式查看   \bs 上下方式查看
"-----------------------------------------------------------------
if filereadable(expand("$VIMFILES/plugin/bufexplorer.vim"))
    nnoremap <C-Tab> :bn<CR>
    nnoremap <C-S-Tab> :bp<CR>
endif

"-----------------------------------------------------------------
" plugin - NERD_tree.vim 以树状方式浏览系统中的文件和目录
" :ERDtree 打开NERD_tree         :NERDtreeClose    关闭NERD_tree
" o 打开关闭文件或者目录         t 在标签页中打开
" T 在后台标签页中打开           ! 执行此文件
" p 到上层目录                   P 到根目录
" K 到第一个节点                 J 到最后一个节点
" u 打开上层目录                 m 显示文件系统菜单（添加、删除、移动操作）
" r 递归刷新当前目录             R 递归刷新当前根目录
"-----------------------------------------------------------------
if filereadable(expand("$VIMFILES/plugin/NERD_tree.vim"))
    " F3 NERDTree 切换
"    map <F3> :NERDTreeToggle<CR>
"    imap <F3> <ESC>:NERDTreeToggle<CR>
    let NERDTreeShowHelp=0
    let NERDChristmasTree=1
    let NERDTreeMouseMode=1
    let NERDTreeShowFiles=1
    let NERDTreeShowLineNumbers=1
    let NERDTreeWinPos='left'
    let NERDTreeWinSize=31
    let NERDTreeDirArrows=0
endif
