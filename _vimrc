"=========================================================================
" DesCRiption: �ʺ��Լ�ʹ�õ�vimrc�ļ���for Linux/Windows, GUI/Console
"
" Last Change: 2010��4��25�� 23ʱ39�� Asins - asinsimple AT gmail DOT com
"
" Author:      Assins - asinsimple AT gmail DOT com
"              Get latest vimrc from http://nootn.com/blog/Tool/22/ 
"
" Version:     1.80
"
"=========================================================================

au GUIEnter * simalt ~x		" ���
set nocompatible            " �ر� vi ����ģʽ
syntax on                   " �Զ��﷨����
colorscheme desert          " �趨��ɫ����
set number                  " ��ʾ�к�
set cursorline              " ͻ����ʾ��ǰ��
set nowrap					" ���Զ�����
set ruler                   " ��״̬�����
set shiftwidth=4            " �趨 << �� >> �����ƶ�ʱ�Ŀ���Ϊ 4
set softtabstop=4           " ʹ�ð��˸��ʱ����һ��ɾ�� 4 ���ո�
set tabstop=4               " �趨 tab ����Ϊ 4
set expandtab				" �� space ��� tab ������
set nobackup                " �����ļ�ʱ������
set noswapfile              " ��ֹ������ʱ�ļ�
set autochdir               " �Զ��л���ǰĿ¼Ϊ��ǰ�ļ����ڵ�Ŀ¼
filetype plugin indent on   " �������
set backupcopy=yes          " ���ñ���ʱ����ΪΪ����
set ignorecase smartcase    " ����ʱ���Դ�Сд��������һ�������ϴ�д��ĸʱ�Ա��ֶԴ�Сд����
set nowrapscan              " ��ֹ���������ļ�����ʱ��������
"set incsearch               " ������������ʱ����ʾ�������
set hlsearch                " ����ʱ������ʾ���ҵ����ı�
"set noerrorbells            " �رմ�����Ϣ����
"set novisualbell            " �ر�ʹ�ÿ�������������
"set t_vb=                   " �ÿմ����������ն˴���
" set showmatch               " ��������ʱ�����ݵ���ת��ƥ��Ķ�Ӧ����
" set matchtime=2             " ������ת��ƥ�����ŵ�ʱ��
set magic                   " ����ħ��
set hidden                  " ��������δ������޸�ʱ�л�����������ʱ���޸��� vim ���𱣴�
"set guioptions-=T           " ���ع�����
"set guioptions-=m           " ���ز˵���
set guioptions+=b			" ˮƽ������
"set smartindent             " ��������ʱʹ�������Զ�����
set backspace=indent,eol,start
                            " ���趨�ڲ���״̬�޷����˸���� Delete ��ɾ���س���
set cmdheight=1             " �趨�����е�����Ϊ 1
set laststatus=2            " ��ʾ״̬�� (Ĭ��ֵΪ 1, �޷���ʾ״̬��)
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&fileencoding}\ [col:%c]:[line:%l]/%L%)\ 
                            " ������״̬����ʾ����Ϣ
set foldenable              " ��ʼ�۵�
set foldmethod=syntax       " �����﷨�۵�
set foldcolumn=0            " �����۵�����Ŀ���
set foldlevelstart=99
setlocal foldlevel=1        " �����۵�����Ϊ
" set foldclose=all           " ����Ϊ�Զ��ر��۵�                            
" nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " �ÿո���������۵�

" return OS type, eg: windows, or linux, mac, et.st..
function! MySys()
    if has("win16") || has("win32") || has("win64") || has("win95")
        return "windows"
    elseif has("unix")
        return "linux"
    endif
endfunction

" �û�Ŀ¼����$VIMFILES
if MySys() == "windows"
    let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
    let $VIMFILES = $HOME.'/.vim'
endif

" �趨doc�ĵ�Ŀ¼
let helptags=$VIMFILES.'/doc'

" �������� �Լ�����֧��
if has("win32")
    set guifont=Inconsolata:h12:cANSI
endif

" ���ö����Ի���
if has("multi_byte")
    " UTF-8 ����
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 "utf-8,gbk,unicode

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif

" Buffers������ݷ�ʽ!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab������ݷ�ʽ!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

"����tab�Ŀ�ݼ�
" map tn :tabnext<cr>
" map tp :tabprevious<cr>
" map td :tabnew .<cr>
" map te :tabedit
" map tc :tabclose<cr>

"���ڷָ�ʱ,�����л��İ����ȼ���Ҫ��������,������·������ƶ�
"��굽�Ϸ�����,��Ҫ<c-w><c-w>k,�ǳ��鷳,������ӳ��Ϊ<c-k>,�л���
"ʱ����÷ǳ�����.
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"һЩ������ӳ��ת���﷨�������һ���ļ��л���˲�ͬ����ʱ���ã�
nnoremap <leader>1 :set filetype=xhtml<CR>
nnoremap <leader>2 :set filetype=css<CR>
nnoremap <leader>3 :set filetype=javascript<CR>
nnoremap <leader>4 :set filetype=php<CR>

" set fileformats=unix,dos,mac
" nmap <leader>fd :se fileformat=dos<CR>
" nmap <leader>fu :se fileformat=unix<CR>

" use Ctrl+[l|n|p|cc] to list|next|previous|jump to count the result
" map <C-x>l <ESC>:cl<CR>
" map <C-x>n <ESC>:cn<CR>
" map <C-x>p <ESC>:cp<CR>
" map <C-x>c <ESC>:cc<CR>


" �� Tohtml ������ CSS �﷨�� html
" syntax/2html.vim��������:runtime! syntax/2html.vim
let html_use_css=1

" Python �ļ���һ�����ã����粻Ҫ tab ��
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

" ѡ��״̬�� Ctrl+c ����
vmap <C-c> "+y
map <c-v> "+gp
imap <c-v> <esc><c-v>i

map Y y$

nmap <c-s> :w<cr>
imap <c-s> <esc>:w<cr>

nmap <TAB> >>
vmap <TAB> >

nmap <BACKSPACE> <<
vmap <BACKSPACE> <

nmap <space> I <esc>
vmap <space> I <esc>

imap <c-l> <c-x><c-l>
nmap <c-a> ggVG

nmap <f2> za


" ��javascript�۵�
let b:javascript_fold=1
" ��javascript��dom��html��css��֧��
let javascript_enable_domhtmlcss=1
" �����ֵ� ~/.vim/dict/�ļ���·��
autocmd filetype javascript set dictionary=$VIMFILES/dict/javascript.dict
autocmd filetype css set dictionary=$VIMFILES/dict/css.dict
autocmd filetype php set dictionary=$VIMFILES/dict/php.dict
"-----------------------------------------------------------------
" plugin - winManager.vim ���ڹ���
"-----------------------------------------------------------------
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
"nmap <F2> :WMToggle<CR>:q<CR>
"nmap <C-F2> :WMToggle<CR>

au VimEnter * WMToggle
au VimEnter * q

"-----------------------------------------------------------------
" plugin - BufExplorer.vim Buffers�л�
" \be ȫ����ʽ�鿴ȫ���򿪵��ļ��б�
" \bv ���ҷ�ʽ�鿴   \bs ���·�ʽ�鿴
"-----------------------------------------------------------------
nnoremap <C-Tab> :bn<CR>
nnoremap <C-S-Tab> :bp<CR>
" <C-Tab>  ��ǰѭ���л���ÿ�� buffer��,���ڵ�ǰ���ڴ� 
" <C-S-Tab>  ���ѭ���л���ÿ�� buffer��,���ڵ�ǰ���ڴ�
" let g:miniBufExplMapCTabSwitchBufs = 1
" <C-Tab>  ��ǰѭ���л���ÿ�� buffer��,���ڵ�ǰ���ڴ� 
" <C-S-Tab>  ���ѭ���л���ÿ�� buffer��,���ڵ�ǰ���ڴ�
" let g:miniBufExplMapWindowNavVim = 1
" ��<C-��ͷ��>�л����������Ҵ�����ȥ
" let g:miniBufExplMapWindowNavArrows = 1

"-----------------------------------------------------------------
" plugin - taglist.vim  �鿴�����б�����Ҫctags����
" F4 ������taglist����
"-----------------------------------------------------------------
if MySys() == "windows"                " �趨windowsϵͳ��ctags�����λ��
    let Tlist_Ctags_Cmd = '"'.$VIMRUNTIME.'/ctags.exe"'
elseif MySys() == "linux"              " �趨windowsϵͳ��ctags�����λ��
    let Tlist_Ctags_Cmd = '/usr/bin/ctags'
endif
nnoremap <silent><F4> :TlistToggle<CR>
let Tlist_Show_One_File = 1            " ��ͬʱ��ʾ����ļ���tag��ֻ��ʾ��ǰ�ļ���
let Tlist_Exit_OnlyWindow = 1          " ���taglist���������һ�����ڣ����˳�vim
let Tlist_Use_Right_Window = 1         " ���Ҳര������ʾtaglist����
let Tlist_File_Fold_Auto_Close=1       " �Զ��۵���ǰ�Ǳ༭�ļ��ķ����б�
let Tlist_Auto_Open = 0
let Tlist_Auto_Update = 1
let Tlist_Hightlight_Tag_On_BufEnter = 1
let Tlist_Enable_Fold_Column = 0
let Tlist_Process_File_Always = 1
let Tlist_Display_Prototype = 0
let Tlist_Compact_Format = 1


"-----------------------------------------------------------------
" plugin - mark.vim ������tags��ǲ�ͬ����ɫ�����ڹۿ���ʽ�Ĳ����
" \m  mark or unmark the word under (or before) the cursor
" \r  manually input a regular expression. ��������.
" \n  clear this mark (i.e. the mark under the cursor), or clear all highlighted marks .
" \*  ��ǰMarkWord����һ��     \#  ��ǰMarkWord����һ��
" \/  ����MarkWords����һ��    \?  ����MarkWords����һ��
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - NERD_tree.vim ����״��ʽ���ϵͳ�е��ļ���Ŀ¼
" :ERDtree ��NERD_tree         :NERDtreeClose    �ر�NERD_tree
" o �򿪹ر��ļ�����Ŀ¼         t �ڱ�ǩҳ�д�
" T �ں�̨��ǩҳ�д�           ! ִ�д��ļ�
" p ���ϲ�Ŀ¼                   P ����Ŀ¼
" K ����һ���ڵ�                 J �����һ���ڵ�
" u ���ϲ�Ŀ¼                 m ��ʾ�ļ�ϵͳ�˵������ӡ�ɾ�����ƶ�������
" r �ݹ�ˢ�µ�ǰĿ¼             R �ݹ�ˢ�µ�ǰ��Ŀ¼
"-----------------------------------------------------------------
" F3 NERDTree �л�
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC>:NERDTreeToggle<CR>
let NERDTreeShowHelp=0
let NERDChristmasTree=1
let NERDTreeMouseMode=1
let NERDTreeShowFiles=1
let NERDTreeShowLineNumbers=1
let NERDTreeWinPos='left'
let NERDTreeWinSize=31

"-----------------------------------------------------------------
" plugin - NERD_commenter.vim   ע�ʹ����õģ�
" [count],cc �������count����������ע��(7,cc)
" [count],cu �������count������ȡ��ע��(7,cu)
" [count],cm �������count�г������ӿ�ע��(7,cm)
" ,cA ����β���� /* */,���ҽ������ģʽ�� ��������дע�͡�
" ע��count������ѡ������Ĭ��Ϊѡ���л�ǰ��
"-----------------------------------------------------------------
let NERDSpaceDelims=1       " ��ע�ͷ������֮����һ���ո�
let NERDCompactSexyComs=1   " ����ע��ʱ���Ӹ��ÿ�


"-----------------------------------------------------------------
" plugin - DoxygenToolkit.vim  ��ע�������ĵ��������ܹ��������ɺ�����׼ע��
"-----------------------------------------------------------------
let g:DoxygenToolkit_authorName="Asins - asinsimple AT gmail DOT com"
let g:DoxygenToolkit_briefTag_funcName="yes"
map <leader>da :DoxAuthor<CR>
map <leader>df :Dox<CR>
map <leader>db :DoxBlock<CR>
map <leader>dc a /*  */<LEFT><LEFT><LEFT>


"-----------------------------------------------------------------
" plugin �C ZenCoding.vim �ܿ�Ĳ����HTML��������
" ������°棺http://github.com/mattn/zencoding-vim
" ��������ɿ���http://nootn.com/blog/Tool/23/
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin �C checksyntax.vim    JavaScript�����﷨������
" Ĭ�Ͽ�ݷ�ʽΪ F5
"-----------------------------------------------------------------
let g:checksyntax_auto = 0 " ���Զ����


"-----------------------------------------------------------------
" plugin - NeoComplCache.vim    �Զ���ȫ���
"-----------------------------------------------------------------
let g:AutoComplPop_NotEnableAtStartup = 1
let g:NeoComplCache_EnableAtStartup = 1
let g:NeoComplCache_SmartCase = 1
let g:NeoComplCache_TagsAutoUpdate = 1
let g:NeoComplCache_EnableInfo = 1
let g:NeoComplCache_EnableCamelCaseCompletion = 1
let g:NeoComplCache_MinSyntaxLength = 3
let g:NeoComplCache_EnableSkipCompletion = 1
let g:NeoComplCache_SkipInputTime = '0.5'
let g:NeoComplCache_SnippetsDir = $VIMFILES.'/snippets'
" <TAB> completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" snippets expand key
imap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)
smap <silent> <C-e> <Plug>(neocomplcache_snippets_expand)


"-----------------------------------------------------------------
" plugin - matchit.vim   ��%���������չʹ������Ƕ�ױ�ǩ�����֮����ת
" % ����ƥ��      g% ����ƥ��
" [% ��λ����     ]% ��λ��β
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - vcscommand.vim   ��%���������չʹ������Ƕ�ױ�ǩ�����֮����ת
" SVN/git��������
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin �C a.vim
"-----------------------------------------------------------------