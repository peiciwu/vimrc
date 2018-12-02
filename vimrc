" Modified by Pei-Ci Wu

" vgod's vimrc
" Tsung-Hsiang (Sean) Chang <vgod@vgod.tw>
" Fork me on GITHUB  https://github.com/vgod/vimrc

" read https://github.com/vgod/vimrc/blob/master/README.md for more info

" For pathogen.vim: auto load all plugins in .vim/bundle
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General Settings

set nocompatible	" not compatible with the old-fashion vi mode
set bs=2		" allow backspacing over everything in insert mode
set history=1000    	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set autoread		" auto read when file is changed from outside
" set nu                " show line number
set tw=80               " set line width
set foldmethod=syntax
set foldlevelstart=20

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden 

filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

syntax on            " syntax highlight
set hlsearch         " search highlighting
set t_Co=256         " 256 color mode

"let g:solarized_termcolors=256

if has("gui_running")   " GUI color and font settings
	"set guifont=Monaco:h14 " Mac own font
        set background=light   " set background
	set cursorline  " highlight current line
	colors solarized  " other colorschemes: gruvbox
else
        set background=dark   " set background
	" colors solarized
        colors herald_pc " dark background: zenburn
        " colors morning " light background: peaksea
endif

set clipboard=unnamed	" yank to the system register (*) by default
set showmatch		" Cursor shows matching ) and }
set showmode		" Show current mode
set wildchar=<TAB>	" start wild expansion in the command line using <TAB>
set wildmenu            " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc

set autoindent		" auto indentation
set incsearch		" incremental search
set nobackup		" no *~ backup files
set copyindent		" copy the previous indentation on autoindenting
set ignorecase		" ignore case when searching
set smartcase		" ignore case if search pattern is all lowercase,case-sensitive otherwise
set smarttab		" insert tabs on the start of a line according to context

set nowrap              " don't wrap lines
set linebreak           " wrap lines at convenient points

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" TAB setting{
   set expandtab        "replace <TAB> with spaces
   set softtabstop=2
   set shiftwidth=2

   au FileType Makefile set noexpandtab
"}      							

" status line {
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

"}


" C/C++ specific settings
autocmd FileType c,cpp,cc  set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"--------------------------------------------------------------------------- 
" Tip #382: Search for <cword> and replace with input() in all open buffers 
"--------------------------------------------------------------------------- 
fun! Replace() 
    let s:word = input("Replace " . expand('<cword>') . " with:") 
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge' 
    :unlet! s:word 
endfun 


"--------------------------------------------------------------------------- 
" USEFUL SHORTCUTS
"--------------------------------------------------------------------------- 
" set leader to ,
let mapleader=","
let g:mapleader=","

"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>

" open the error console
map <leader>ec :botright cope<CR> 
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>

" --- move around splits {
" move to and maximize the below split 
"map <C-J> <C-W>j<C-W>_
" move to and maximize the above split 
"map <C-K> <C-W>k<C-W>_
" move to and maximize the left split 
nmap <c-h> <c-w>h<c-w><bar>
" move to and maximize the right split  
nmap <c-l> <c-w>l<c-w><bar>
set wmw=0                     " set the min width of a window to 0 so we can maximize others 
set wmh=0                     " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab 
map <S-H> gT
" go to next tab
map <S-L> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A>      <Home>
cnoremap <C-E>      <End>
cnoremap <C-K>      <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h

" Writing Restructured Text (Sphinx Documentation) {
   " Ctrl-u 1:    underline Parts w/ #'s
   noremap  <C-u>1 yyPVr#yyjp
   inoremap <C-u>1 <esc>yyPVr#yyjpA
   " Ctrl-u 2:    underline Chapters w/ *'s
   noremap  <C-u>2 yyPVr*yyjp
   inoremap <C-u>2 <esc>yyPVr*yyjpA
   " Ctrl-u 3:    underline Section Level 1 w/ ='s
   noremap  <C-u>3 yypVr=
   inoremap <C-u>3 <esc>yypVr=A
   " Ctrl-u 4:    underline Section Level 2 w/ -'s
   noremap  <C-u>4 yypVr-
   inoremap <C-u>4 <esc>yypVr-A
   " Ctrl-u 5:    underline Section Level 3 w/ ^'s
   noremap  <C-u>5 yypVr^
   inoremap <C-u>5 <esc>yypVr^A
"}


"--------------------------------------------------------------------------- 
" PROGRAMMING SHORTCUTS
"--------------------------------------------------------------------------- 

" --- ctags setting
" Ctrl-[ jump out of the tag stack (undo Ctrl-])
" map <C-[> <ESC>:po<CR>
map  g
" use ,S to jump to tag in a horizontal split
nnoremap <silent> ,S <C-W><C-]> 
" use ,V to jump to tag in a vertical split
nnoremap <silent> ,V  :let word=expand("<cword>")<CR>:vsp<CR>:wincmd w<cr>:exec("tag ". word)<cr>
" use ,T to jump to tag in a new tab
"nnoremap <silent> ,T :tab split<CR>:exec("tag ".expand("<cword>"))<CR>


" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" Enable omni completion. (Ctrl-X Ctrl-O)
"autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
"autocmd FileType c set omnifunc=ccomplete#Complete
"autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
"if has("autocmd") && exists("+omnifunc")
"  autocmd Filetype *
"              \	if &omnifunc == "" |
            "\		setlocal omnifunc=syntaxcomplete#Complete |
              "\	endif
"endif

" Close automatically the preview window after a moni completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" build Ctags database
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .
map <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ../.<CR>

"auto add right parenthesis
":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
function ClosePair(char)
if getline('.')[col('.') - 1] == a:char
return "\<Right>"
else
return a:char
endif
endf

" build CScope database
" find . -name "*.c" -name "*.cc" -o -name "*.h" -o -name "*.cpp" -o -name "*.hpp" -o -name ".tcc" -o -name "*.tcl" -o -name "*.cmd" -o -name "*.ecmd" -o -name "*.pl" -o -name "*.py" -name "makefile" > cscope.files
" cscope -q -R -b -i cscope.files

" make CSS omnicompletion work for SASS and SCSS
" autocmd BufNewFile,BufRead *.scss             set ft=scss.css
" autocmd BufNewFile,BufRead *.sass             set ft=sass.css

"--------------------------------------------------------------------------- 
" ENCODING SETTINGS
"--------------------------------------------------------------------------- 
set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1

fun! ViewUTF8()
	set encoding=utf-8                                  
	set termencoding=big5
endfun

fun! UTF8()
	set encoding=utf-8                                  
	set termencoding=big5
	set fileencoding=utf-8
	set fileencodings=ucs-bom,big5,utf-8,latin1
endfun

fun! Big5()
	set encoding=big5
	set fileencoding=big5
endfun

"
"--------------------------------------------------------------------------- 
" PLUGIN SETTINGS
"--------------------------------------------------------------------------- 

" ------- vim-latex - many latex shortcuts and snippets {

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"}


" --- Command-T
let g:CommandTMaxHeight = 15

" --- SuperTab
let g:SuperTabDefaultCompletionType = "context"

" --- EasyMotion
"let g:EasyMotion_leader_key = '<Leader>m' " default is <Leader>w
hi link EasyMotionTarget ErrorMsg
hi link EasyMotionShade  Comment


" --- TagBar
" toggle TagBar with F8
nnoremap <silent> <F8> :TagbarToggle<CR> 
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1
" let g:tagbar_ctags_bin = '/sierra/project/tools/linux_x86_64_2.12/bin/ctags' "Proper ctags locations
"let g:tagbar_width = 26                   "Default is 40, seems too wide


" --- NERDTree
let NERDTreeShowHidden=1
let NERDQuitOnOpen=0
"let NERDTreeShowLineNumbers=1
let NERDTreeChDirMode=0
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.git', '\.hg', 'CVS']
"let NERDTreeBookmarksFile=get_cache_dir('NERDTreeBookmarks')
let s:NERDTree_view_bookmark=$SDA_VIEW_DIR.'/.NERDTreeBookmarks'
if filewritable(s:NERDTree_view_bookmark)
  let NERDTreeBookmarksFile=s:NERDTree_view_bookmark
endif


nnoremap <F5> :NERDTreeToggle<CR>
nnoremap <F6> :NERDTreeFind<CR>


" --- unite
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#set_profile('files', 'smartcase', 1)
call unite#custom#profile('files', 'smartcase', 1)
call unite#custom#source('line,outline','matchers','matcher_fuzzy')
call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
  \ 'ignore_pattern', join([
  \ '\.git/',
  \ '\cvs/',
  \ '\.sass-cache/',
  \ '\vendor/',
  \ '\node_modules/',
  \ ], '\|'))


"let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_rec_max_cache_files=5000
let g:unite_force_overwrite_statusline=0
let g:unite_prompt='>> '
let g:unite_source_grep_max_candidates=3000
"let g:unite_kind_file_vertical_preview=1
"let g:unite_enable_split_vertically=1
let g:unite_source_grep_default_opts = '-nH --exclude=tags --exclude=TAGS --exclude-dir=CVS --exclude=cscope.files --exclude=cscope.out'
"let g:unite_update_time=100
let g:unite_winheight=30
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1

function! s:unite_settings()
  nmap <buffer> q <plug>(unite_exit)
  nmap <buffer> <esc> <plug>(unite_exit)
  "imap <buffer> <esc> <plug>(unite_exit)
  imap <buffer> <C-j> <Plug>(unite_select_next_line)
  imap <buffer> <C-k> <Plug>(unite_select_previous_line)
  imap <buffer> <C-a> <Plug>(unite_choose_action)
  imap <silent><buffer><expr> <C-s> unite#do_action('split')
  imap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
  imap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
  nmap <silent><buffer><expr> <C-s> unite#do_action('split')
  nmap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction
autocmd FileType unite call s:unite_settings()

nmap <space> [unite]
nnoremap [unite] <nop>
"nnoremap <silent> [unite]<space> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec/async:! buffer file bookmark<cr><c-u>
"nnoremap <silent> [unite]f :<C-u>Unite -toggle -auto-resize -buffer-name=files file_rec/async:!<cr><c-u>
"nnoremap <silent> [unite]e :<C-u>Unite -buffer-name=recent file<cr>
"nnoremap <silent> [unite]y :<C-u>Unite -buffer-name=yanks history/yank<cr>
"nnoremap <silent> [unite]l :<C-u>Unite -auto-resize -buffer-name=line line<cr>
"nnoremap <silent> [unite]b :<C-u>Unite -auto-resize -buffer-name=buffers buffer<cr>
"nnoremap <silent> [unite]/ :<C-u>Unite -no-quit -buffer-name=search grep:.<cr>
"nnoremap <silent> [unite]m :<C-u>Unite -auto-resize -buffer-name=mappings mapping<cr>
"nnoremap <silent> [unite]s :<C-u>Unite -quick-match buffer<cr>

" General purpose
nnoremap [unite]<space> :Unite -no-split -start-insert source<cr>

" Files
nnoremap [unite]f :Unite -no-split -start-insert file_rec/async:
nnoremap [unite]F :Unite -no-split -start-insert file_rec/async:../

" Grepping
nnoremap [unite]g :Unite -no-split -auto-preview grep:
nnoremap [unite]G :Unite -no-quit -auto-preview grep:
"nnoremap [unite]d :Unite -no-split grep:.:-s:\(TODO\|FIXME\)<cr>

" Content
nnoremap [unite]o :Unite outline <cr>
nnoremap [unite]l :Unite line<cr>
nnoremap [unite]t :Unite tag<cr>

" Quickly switch between recent things
nnoremap [unite]R :Unite -no-split buffer tab file_mru directory_mru<cr>
nnoremap [unite]b :Unite -no-split buffer<cr>
nnoremap [unite]m :Unite -no-split file_mru<cr>

" Yank history
nnoremap [unite]y :Unite -buffer-name=yanks history/yank<cr>

" CScope
nnoremap [unite]s :Unite -no-split -auto-preview cscope/

" Repeate the last Unite action
nnoremap [unite]r :UniteResume<cr>
