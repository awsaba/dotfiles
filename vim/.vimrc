set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Other settings
let g:airline#extensions#tabline#enabled = 1

let g:ctrlp_working_path_mode = 'ra'

" Ubuntu 12.04 package does not support -s
let g:ack_default_options = " -H --nocolor --nogroup --column"

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" Bundle 'majutsushi/tagbar'
" Bundle 'altercation/vim-colors-solarized'

" Github repos of the user 'vim-scripts'
" => can omit the username part
" Bundle 'L9'
"Bundle 'FuzzyFinder'
Bundle 'peaksea'
Bundle 'restore_view.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'airblade/vim-gitgutter'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'Townk/vim-autoclose'
Bundle 'bling/vim-airline'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/syntastic'

Plugin 'rust-lang/rust.vim'
"Bundle 'phildawes/racer'

Bundle 'altercation/vim-colors-solarized'

" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...
filetype plugin indent on     " required!
syntax on

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" racer settings
"let g:racer_cmd = "/home/awsaba/src/rust/racer/target/release/racer"
"let $RUST_SRC_PATH = "/home/awsaba/src/rust/rust/src"

" NERDTree settings "
"
"
" autocmd vimenter * NERDTree
autocmd vimenter * if (!argc()) | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | en

map <C-n> :NERDTreeToggle<CR>

set background=dark
" t_Co=16,g:solarize_termtrans=1 seems to do work:
" 1. Local iterm2 on OS Xwith iterm2 set to solarized palette
" 2. ssh into a Linux box using iterm2 w/paletter
" 3. iterm2 w/palette, ssh w/ byobu/tmux on linux
" 4. Local xfce4-terminal w/palette on the same linux host
" 5. Byobu/tmux in xfce4-terminal w/palette on the same host shows
"    bold instead of normal for elements that are supposed to be grey,
"    which is less irritating than some of the other variations.  GNU
"    screen in the xfce4-terminal does not seem to have the same issue.
set t_Co=16
let g:solarized_termtrans=1
colorscheme solarized
" color peaksea

" The fancy nu/rnu combo is 7.4 and newer only
" after setting the colorscheme because it resets hl-CursorLineNr
if version >= 704
    set relativenumber              " Relative line numbers on
    set number                      " Line numbers on
    highlight CursorLineNr cterm=none ctermfg=2
else
    Bundle 'myusuf3/numbers.vim'
endif


" Some stuff taken from spf13
"
" I don't care for some their general settings for mouse/clipboard/etc.
"
" General {
    set mouse=a                         " Don't copy linenumbers
    set mousehide

    "set autowrite                       " Automatically write a file when #
    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit #
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows#
    set virtualedit=onemore             " Allow for cursor beyond last char#
    set history=1000                    " Store a ton of history (default i#
    "set spell
    set hidden

" }

" Vim UI {
    set tabpagemax=15               " Only show 15 tabs
    "Don't need showmode with airline
    "set showmode                    " Display the current mode

    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter
    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=%{fugitive#statusline()} " Git Hotness
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=%{tagbar#currenttag('\ [%s]\ ','')}
        "set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    "set wildignore+=*/.git/*        " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set colorcolumn=80

" }
"
" Formatting {

    set nowrap                      " Wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    "set matchpairs+=<:>             " Match, to be used with %
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    " Remove trailing whitespaces and ^M chars
    autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,rust autocmd BufWritePre <buffer> call StripTrailingWhitespace()
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig

" }

"Key/Command Mappings {
    " For when you forget to sudo.. Really Write the file.
    cmap w!! w !sudo tee % >/dev/null

    let mapleader=","
    nmap <Leader>b :TagbarToggle<cr>
    nmap <Leader>n :bnext<cr>
    nmap <Leader>p :bprev<cr>
    nmap <Leader>d :bprev<bar>bdelete#<cr>
    nmap <Leader>g :CtrlPBuffer<cr>
" }

" Functions {
    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Also taken from spf13
        " To disable the stripping of whitespace, add the following to your
        " .vimrc.local file:
        "   let g:spf13_keep_trailing_whitespace = 1
        if !exists('g:spf13_keep_trailing_whitespace')
            " Preparation: save last search, and cursor position.
            let _s=@/
            let l = line(".")
            let c = col(".")
            " do the business:
            %s/\s\+$//e
            " clean up: restore previous search history, and cursor position
            let @/=_s
            call cursor(l, c)
        endif
    endfunction
    " }

" }

" Initialize directories {
" This was taken from spf13, but without the spf13 vars because
" I don't quite need local configs yet.
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    "TODO put backup files in .git if found?
    let common_dir = parent . '/.' . prefix

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
" }



call InitializeDirectories()

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif

