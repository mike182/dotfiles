" vim-plug install
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim-plug plugins
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" plugin on GitHub repo
" ---------------------
Plug 'Rip-Rip/clang_complete'
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdtree-project-plugin'
Plug 'ervandew/supertab' " completion tab
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-eunuch' " Helpers for UNIX
Plug 'tpope/vim-fugitive' " A git wrapper
Plug 'tpope/vim-commentary' " Comment stuff out
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-markdown' " md runtime files
Plug 'vim-scripts/a.vim' " quick switch source / header
" Plug 'vim-scripts/google.vim'
" -------
" Testing
" -------
Plug 'SirVer/ultisnips'
" Plug 'dense-analysis/ale' " syntax check
" Plug 'scrooloose/syntastic' " Syntax Checker
" Plug 'vhdirk/vim-cmake'
Plug 'kana/vim-smartinput' " autoclosing
" Plug 'Raimondi/delimitMate' " autoclosing
Plug 'godlygeek/tabular' " Alignment
Plug 'tpope/vim-apathy' " Path searching options
Plug 'tpope/vim-surround' " surrounding: cs<char1><char2>
Plug 'tpope/vim-repeat' " Repeat support for surround and unimpaired
Plug 'vim-scripts/Shebang' " set correct shebang
Plug 'majutsushi/tagbar'
" ---
" Old
" ---
" Plug 'derekwyatt/vim-scala'

" Initialize plugin system
call plug#end()

filetype on
filetype plugin on
filetype indent on

set nocompatible

set shell=zsh

set t_Co=256
colorscheme jellybeans

syntax on                       " syntax coloring

" Style:
set expandtab                   " replace tabs by spaces
set smarttab                    " insert shiftwidth spaces instead of tabs
set shiftwidth=4                " indent using 2 spaces
set softtabstop=4               " tabs account for 2 spaces
set tabstop=8                   " keep a standard size for real tabs
set listchars=tab:>\ ,eol:$     " set symbols for tabstops and EOLs
set nowrap                      " do not split the line if it is too long "TEST
set modelines=5                 " enable modlines
" set colorcolumn=80              " highlight columns after 80

" Edition:
set backspace=indent,eol,start  " backspace over everything
set cpoptions+=$                " 'cw' and friends puts a $ at the end
set formatoptions+=1            " don't break lines after a single-char word
set hidden                      " keep buffers around hidden

" Search:
set hlsearch                    " highlight last search matches
set incsearch                   " show incremental search matches
set ignorecase                  " ignore case when searching
set smartcase                   " ... except if there is one uppercase character
set wrapscan                    " wrap around end of file

" Brackets:
set matchpairs+=<:>             " <> also are a matching pair
set showmatch                   " show matching bracket when inserting
set matchtime=3                 " quickly show the matching bracket

" General:
set autoindent                  " indent new lines
set autoread                    " watch for file changes by other programs
set autowrite                   " save before CTRL-O and friends
set completeopt=menu,longest    " disable the preview window
set display=uhex                " show unprintable characters as <xx>
set encoding=utf-8              " use a sane mutltibyte encoding
set laststatus=2                " always show the status line
set ruler                       " show position in file
set scrolloff=5                 " keep some space at the screen top/bottom
set shortmess=aoOtTI            " be less verbose in prompts and messages
set showcmd                     " show partial commands
set showmode                    " show current mode
set timeoutlen=200              " max interval between keys in a mapped sequence (default 1000)
set visualbell
set t_vb=
set number

" Statusline:
"silent! set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" Tools:
set tags=tags;/                 " look for ctags in parent directories
set diffopt+=iwhite             " ignore whitespace when diff'ing

" Wildcards:
set wildignore+=*.o,*.a,*.pyc,*.git,*.svn,*.sw*,*.d,*.DS_Store,*.pdf
set wildmenu                    " better command line completion menu
set wildmode=longest,list       " select the first match

" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END
set cinoptions=:0,g0,(0,Ws,l1

" Term: change cursor shape based on mode (iTerm2)
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"" Panes: ^H,^J,^K,^L
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l

"" Tabs: H/L
map L gt
map H gT

" Fix moving around wrapped lines
map j gj
map k gk

"" Cleanup:
" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Highlight trailing whitespace and lines longer than 80 columns.
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
" Whitespace at the end of a line. This suppresses whitespace that has just been typed
au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
au InsertEnter * call matchdelete(w:m1)
au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
au InsertLeave * call matchdelete(w:m2)
au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)

"" CtrlP:
nnoremap ,, :CtrlP<CR>
nnoremap ,m :CtrlPCurWD<CR>
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_max_height = 40
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](build|release|test|unittests|examples)$'
      \ }

"" A:
let g:alternateExtensions_cpp = "hpp,hh,h"
let g:alternateExtensions_hh = "cpp,cc,c"

"" Tagbar:
nnoremap \\g :TagbarOpen<CR>

"" Clang_complete:
let g:clang_auto_select = 2
let g:clang_complete_auto = 1
let g:clang_complete_copen = 1
let g:clang_hl_errors = 1
let g:clang_periodic_quickfix = 0
let g:clang_snippets = 0
let g:clang_snippets_engine = "UltiSnips"
let g:clang_conceal_snippets = 1
let g:clang_trailing_placeholder = 1
let g:clang_close_preview = 1
let g:clang_exec = "clang"
let g:clang_user_options = ""
let g:clang_auto_user_options = "compile_commands.json"
let g:clang_use_library = 1
let g:clang_library_path = "/usr/local/lib/"
let g:clang_library_path = "/usr/lib/llvm-11/lib/"
let g:clang_sort_algo = "priority"
let g:clang_complete_macros = 0
let g:clang_complete_patterns = 0
let g:clang_debug = 1

"" Clangformat:
" map <leader>f :pyf $HOME/.vim/scripts/clang-format.py<CR>
" imap <leader>f <ESC>:pyf $HOME/.vim/scripts/clang-format.py<CR>i

"" Remap:
nmap <leader>l :set list!<CR>
map ,p :set paste!<CR>
map ,l :setlocal number!<CR>
nmap ,c :tabnew<CR>
nmap ,d	:tabclose<CR>

"" Tagbar:
nnoremap ,t :TagbarOpen<CR>
nnoremap ,s :TagbarShowTag<CR>
nnoremap <leader>[ :TagbarToggle<CR>

"" Completion / SuperTab:
" let g:SuperTabDefaultCompletionType = 'context'
" set completeopt+=menuone,longest

" Header insert in h,hpp
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef __" . gatename . "__"
  execute "normal! o#define __" . gatename . "__"
  execute "normal! Go#endif // __" . gatename . "__"
  normal! ko
endfunction
autocmd BufNewFile *.{h,hh,hpp} call <SID>insert_gates()

" disable annoying hlsearch on demand
nnoremap <leader><space> :noh<cr>

" Remap Caps Lock to ESC
"let hasMac = has('unix') && system("uname") == "Darwin\n"
"if has('unix') && !hasMac
"  silent !whereis xmodmap && xmodmap -e "clear lock" -e "keycode 0x42 = Escape"
"endif

" Various mapping to set indent
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

" let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
