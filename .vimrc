set nocompatible
set noswapfile
set nowritebackup
set nobackup
set encoding=utf-8
set guifont="Ricty for Powerline"\ 10

"----------------------------
" NeoBundle
"----------------------------
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.vim/bundle'))
  NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif

"NeoBundle 'Shougo/neobundle.vim'

" ------- Bundles here -------
NeoBundle 'sjl/badwolf'
NeoBundle 'fugitive.vim'
NeoBundle 'surround.vim'
NeoBundle 'mru.vim'
NeoBundle 'lightline.vim'
NeoBundle 'EasyMotion'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'The-NERD-tree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Lokaltog/powerline-fontpatcher'

" Ruby/Rails
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'Shougo/neocomplete.vim'

" CoffeeScripts
NeoBundle 'kchmck/vim-coffee-script'

" tweet
"NeoBundle 'TwitVim'
NeoBundle 'basyura/TweetVim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'mattn/favstar-vim'

" NeoBundle backup
" colorscheme's
"NeoBundle 'vim-scripts/phd'
"NeoBundle 'vim-scripts/harlequin'
"NeoBundle 'molokai'
"NeoBundle 'w0ng/vim-hybrid'
"NeoBundle 'chriskempson/vim-tomorrow-theme'

" plugins
"NeoBundle 'vimfiler'
"NeoBundle 'L9'
"NeoBundle 'FuzzyFinder'
"NeoBundle 'terryma/vim-multiple-cursors'

" Ruby/Rails
"NeoBundle 'snipMate'
" ----------------------------

"----------------------------

filetype indent plugin on
filetype indent on

" ----------------------------
" display
" ----------------------------
set t_Co=256
set t_Sf=[3%dm
set t_Sb=[4%dm
colorscheme badwolf
"colorscheme railscasts
set background=dark
syntax enable

set number
set showmode
set title
set list
set listchars=tab:>-,trail:-,extends:>,precedes:< " eol:$

" ----------------------------
set hidden
set wildmenu
set showcmd
set hlsearch

" ----------------------------
set ignorecase
set smartcase
set autoindent
set autoread
set nostartofline
set ruler
set clipboard=unnamed,autoselec
set backspace=indent,eol,start
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=1
set number
set notimeout ttimeout ttimeoutlen=200
set pastetoggle=<F11>
set splitbelow
set splitright

" ----------------------------
set shiftwidth=2
set softtabstop=2
set expandtab
set tabstop=2

" ----------------------------
"highlight link ZenkakuSpace Error
"match ZenkakuSpace /　/

" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""

" ----------------------------
" backup
" ----------------------------
" set backup
" set backupdir=~/.vim/vim_backup
" set swapfile
" set directory=~/.vim/vim_swap

" ----------------------------
" key map
" ----------------------------
let mapleader=" "
inoremap jj <Esc>
nmap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Leader>o :only<CR>
nnoremap <Leader>r :QuickRun<CR>
" Ctrl+hjklでウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" resize window
function! s:resizeWindow()
  let mappings = []
  let curwin = winnr()
  wincmd j | let target1 = winnr() | exe curwin "wincmd w"
  wincmd l | let target2 = winnr() | exe curwin "wincmd w"

  if curwin == target1
  call add(mappings,['j','-']) | call add(mappings,['k','+'])
  else
  call add(mappings,['j','+']) | call add(mappings,['k','-'])
  endif

  if curwin == target2
  call add(mappings,['h','>']) | call add(mappings,['l','<'])
  else
  call add(mappings,['h','<']) | call add(mappings,['l','>'])
  endif

  for i in mappings
  execute printf('nnoremap <buffer> <silent> %s <C-w>%s:echo "window-resize"<CR>',i[0],i[1])
  endfor
  nnoremap <buffer> <silent> = <C-w>=:echo "window-resize"<CR>
  nnoremap <buffer> <silent> <C-g> :<C-u>call <SID>deleteMappings(['=','j','k','h','l','<C-g>'])<CR>:redraw!<CR>

  echohl ModeMsg
  echo "window-resize"
endfunction

function! s:deleteMappings(mappings)
  for i in a:mappings
  execute 'nunmap <buffer> ' . i
  endfor
  echohl None
endfunction

nnoremap <C-W>r :<C-u>call <SID>resizeWindow()<CR>

" ----------------------------
" auto command
" ----------------------------
augroup BufferAu
autocmd!
autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
augroup END

" ----------------------------
" Plugin setting
" ----------------------------
" NERDTree
nmap <silent> <C-e>      :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
omap <silent> <C-e>      :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc>:NERDTreeToggle<CR>
cmap <silent> <C-e> <C-u>:NERDTreeToggle<CR>
autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeIgnore=['\.clean$', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=0
let g:NERDTreeMouseMode=2

" rails.vim
let g:rails_level=3


" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0
hi IndentGuidesOdd  ctermbg=237
hi IndentGuidesEven ctermbg=238

" Quickrun
augroup RSpec
autocmd!
autocmd BufWinEnter,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END
let g:quickrun_config = {}
let g:quickrun_config = {'*': {'split': ''}}
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config['ruby.rspec'] = {'command': "spec", 'cmdopt': "-l {line('.')} -cfs"}
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright 15sp",
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 40,
\   }
\}

" lightline
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'component': {
        \   'readonly': '%{&readonly?"x":""}',
        \   'yuno': 'X / _ / X <'
        \ },
        \ 'separator': { 'left': "\u2b80", 'right': "\u2b82" },
        \ 'subseparator': { 'left': "\u2b81", 'right': "\u2b83" },
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ ['yuno'], [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



"----------------------------
" NeoComplete
"----------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" sample settings ==> https://github.com/Shougo/neocomplete.vim#configuration-examples
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
let g:neocomplete#max_list = 20

" Define dictionary.
let $DOTVIM = $HOME . '/.vim'
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'ruby' : $DOTVIM.'/dict/ruby.dict'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"

" for twitvim
let twitvim_force_ssl = 1
let twitvim_count = 40

" for tweetvim
let g:tweetvim_display_icon = 1
let g:tweetvim_tweet_per_page = 60

nnoremap <silent><Leader>tw :<C-u>tabnew <Bar> TweetVimHomeTimeline<CR>
nnoremap <silent><Leader>tl :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent><Leader>tm :<C-u>TweetVimMentions<CR>
nnoremap <Leader>ts :<C-u>TweetVimSay<CR>

" セパレータを飛ばして移動する
" ページの先頭や末尾でそれ以上 上/下 に移動しようとしたらページ移動する
function! s:tweetvim_vertical_move(cmd)
    execute "normal! ".a:cmd
    let end = line('$')
    while getline('.') =~# '^[-~]\+$' && line('.') != end
        execute "normal! ".a:cmd
    endwhile
    " 一番下まで来たら次のページに進む
    let line = line('.')
    if line == end
        call feedkeys("\<Plug>(tweetvim_action_page_next)")
    elseif line == 1
        call feedkeys("\<Plug>(tweetvim_action_page_previous)")
    endif
endfunction

"----------------------------
" vim-coffee-script
"----------------------------
au BufRead,BufNewFile,BufReadPre *.coffee   set filetype=coffee
" インデント設定
autocmd FileType coffee    setlocal sw=2 sts=2 ts=2 et
" オートコンパイル
  "保存と同時にコンパイルする
autocmd BufWritePost *.coffee silent make!
  "エラーがあったら別ウィンドウで表示
autocmd QuickFixCmdPost * nested cwindow | redraw!
" Ctrl-cで右ウィンドウにコンパイル結果を一時表示する
nnoremap <silent> <C-C> :CoffeeCompile vert <CR><C-w>h

