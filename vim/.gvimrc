" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" set guifont=DejaVu\ Sans\ Mono\ 10
colorscheme darkspectrum

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=b
set guioptions-=B

set hidden

" Omni completion
" filetype plugin on
" set ofu=syntaxcomplete#Complete
" set Ccompletition
set completeopt=longest,menuone

" Colors and Fonts{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
syntax enable

"Font type and size
"set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
"set gfn=ProggyCleanTT\ 12
"set guifont=Terminus\ 8
"set guifont=Monospace\ 11
"set guifont=Monaco\ 10
"set guifont=Inconsolata\ 11
set guifont=Droid\ Sans\ Mono\ 9


"set the right enconding
" set encoding=latin1

"set Pattern matching highlight
"hi MatchParen guifg=#000000 guibg=#D0D090

if has("gui_running")
    set guioptions-=T
endif

"Highlight spaces at the end of lines
let c_space_errors=1
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
"""""""""""""""""""""""""""""""""""""""""""}}}

" VIM userinterface{{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"When moving vertical, start scrolling 7 lines before reaching the extremity"{{{
set so=7

"Turn on WiLd menu - command-line completion operates in an enhanced mode.
" set wildmenu

"Always show current position
set ruler

"The commandbar is 1 line high
set cmdheight=1

"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
" set hid

"Set backspace
" set backspace=eol,start,indent

"Backspace and cursor keys wrap to
"set whichwrap+=<,>,h,l

"Ignore case when searching
set ignorecase

"You will see results while you type
set incsearch

"Set magic on
set magic
"Use abreviation in the messages (like + instead of Modified)

"set shortmess=at

"show matching bracets
"set showmatch

"How many tenths of a second to blink
set mat=2

"Highlight search things
" set hlsearch
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" Statusline (the bar at the bottom){{{
"""""""""""""""""""""""""""""""
"Use statusline in every window
set laststatus=2

"Format the statusline
set statusline=\ File:\ %F%m%r%h\ %w\ \ \ Current\ dir:\%r%{getcwd()}%h
""""""""""""""""""""""""""""""""""}}}

let g:miniBufExplSplitBelow = 0
let g:miniBufExplForceSyntaxEnable = 0
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMaxSize = 0
let g:miniBufExplModSelTarget = 1
let g:miniBufExplTabWrap = 1
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplCheckDupeBufs = 0
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-x> :BD<CR>

" Minibuffer{{{
""""""""""""""""""""""""""""""
"Show the miniBufExplorer from the start
let g:miniBufExplorerMoreThanOne = 0

"Not using because I don't use the vertival window
"Use a vertical windows
"let g:miniBufExplVSplit = 5

"Put the miniBufExplorer windows at the right
"let g:miniBufExplSplitBelow=1

"Maximum size of the mini buffer explorer window
"let g:miniBufExplMaxSize = 15

"Still haven't discovered what it does
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
"
" make tabs show complete (no broken on two lines)
" let g:miniBufExplTabWrap = 1

" If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
" let g:miniBufExplModSelTarget = 1

" If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
" let g:miniBufExplUseSingleClick = 1

"for buffers that have NOT CHANGED and are NOT VISIBLE.
highlight MBENormal guifg=LightBlue

" for buffers that HAVE CHANGED and are NOT VISIBLE
highlight MBEChanged guifg=Red

" buffers that have NOT CHANGED and are VISIBLE
highlight MBEVisibleNormal term=bold cterm=bold gui=bold guifg=LightGreen

" buffers that have CHANGED and are VISIBLE
"highlight MBEVisibleChanged term=bold cterm=bold gui=bold guifg=Green

let g:bufExplorerSortBy = "name"

"autocmd BufRead,BufNew :call UMiniBufExplorer

"""""""""""""""""""""""""""""""""""
" Stolen from http://dev.gentoo.org/~bass/configs/vimrc.html
"
" Adapt the status line accourding to the window
"""""""""""""""""""""""""""""""""""
if has("autocmd")
    au FileType qf
                \ if &buftype == "quickfix" |
                \     setlocal statusline=%2*%-3.3n%0* |
                \     setlocal statusline+=\ \[Compiler\ Messages\] |
                \     setlocal statusline+=%=%2*\ %<%P |
                \ endif

    fun! <SID>FixMiniBufExplorerTitle()
        if "-MiniBufExplorer-" == bufname("%")
            setlocal statusline=%2*%-3.3n%0*
            setlocal statusline+=\[Buffers\]
            setlocal statusline+=%=%2*\ %<%P
        endif
    endfun

    au BufWinEnter *
                \ let oldwinnr=winnr() |
                \ windo call <SID>FixMiniBufExplorerTitle() |
                \ exec oldwinnr . " wincmd w"
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"let NERDTree
let NERDTreeQuitOnOpen=0
map <F2> :NERDTreeToggle<CR>
"let NERDTreeChDirMode=2
"let NERDTreeHightlightCursorline=1

"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
