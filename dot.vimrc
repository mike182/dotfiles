set nocompatible		" be iMproved, required
filetype off			" required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" plugin on GitHub repo
Plugin 'Rip-Rip/clang_complete'
Plugin 'scrooloose/nerdtree'
Plugin 'ervandew/supertab'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-markdown'
Plugin 'vim-jp/cpp-vim'
Plugin 'tpope/vim-afterimage'

Plugin 'vim-scripts/Shebang'
Plugin 'godlygeek/tabular'
Plugin 'scrooloose/syntastic'
Plugin 'pyflakes/pyflakes' " deprecated
" Plugin 'majutsushi/tagbar'
" Plugin 'tpope/vim-obsession'
" Plugin 'derekwyatt/vim-scala'
" Plugin 'bronson/vim-trailing-whitespace'
" Plugin 'tpope/vim-pastie'
"
" w0ng/vim-hybrid
" Plugin 'xuhdev/SingleCompile'
" Plugin 'xolox/vim-easytags'
" Plugin 'xolox/vim-misc'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'a.vim'
Plugin 'google.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

" colorscheme base16-default
" let base16colorspace=256  " Access colors present in 256 colorspace
" set background=dark

" set t_Co=256
colorscheme jellybeans

syntax on                       " syntax coloring

" Style:
set expandtab                   " replace tabs by spaces
set smarttab                    " insert shiftwidth spaces instead of tabs
set shiftwidth=2                " indent using 2 spaces
set softtabstop=2               " tabs account for 2 spaces
set tabstop=8                   " keep a standard size for real tabs
set colorcolumn=80              " highlight columns after 80
set nowrap " do not split the line if it is too long "TEST
set listchars=tab:>\ ,eol:$    " set symbols for tabstops and EOLs

" Edition:
set backspace=indent,eol,start  " backspace over everything
set concealcursor=niv           " conceal in all modes
set conceallevel=2              " hide concealed text unless replacement char is defined
set cpoptions+=$                " 'cw' and friends puts a $ at the end
set cpoptions+=ces$ " make the 'cw' and like commands put a $ at the end "TEST
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
set matchtime=2                 " quickly show the matching bracket

" General:
set autoindent                  " indent new lines
set autoread                    " watch for file changes by other programs
set autowrite                   " save before CTRL-O and friends
set completeopt=menu,longest    " disable the preview window
set display=uhex                " show unprintable characters as <xx>
set encoding=utf-8              " use a sane mutltibyte encoding
set laststatus=2                " always show the status line
set mouse=a                     " enable the xterm mouse (rarely useful)
set relativenumber              " show line offsets relative to cursor
set ruler                       " show position in file
set scrolloff=3                 " keep some space at the screen top/bottom
set shortmess=aoOtTI            " be less verbose in prompts and messages
set showcmd                     " show partial commands
set showmode                    " show current mode
set timeoutlen=200              " max interval between keys in a mapped sequence (default 1000)
set visualbell

" Statusline:
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" disable annoying hlsearch on demand
nnoremap <leader><space> :noh<cr>

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
" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g
" Highlight trailing whitespace and lines longer than 80 columns.
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow

"" CtrlP:
nnoremap ,, :CtrlP<CR>
nnoremap ,m :CtrlPCurWD<CR>
let g:ctrlp_clear_cache_on_exit = 0
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
let g:clang_periodic_quickfix = 1
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
let g:clang_sort_algo = "priority"
let g:clang_complete_macros = 0
let g:clang_complete_patterns = 0

"" Clangformat:
map <leader>f :pyf $HOME/.vim/scripts/clang-format.py<CR>
imap <leader>f <ESC>:pyf $HOME/.vim/scripts/clang-format.py<CR>i

"" Remap:
nmap <leader>l :set list!<CR>
map ,p :set paste!<CR>
map ,l :setlocal number!<CR>
nmap ,c :tabnew<CR>
nmap ,d	:tabclose<CR>


" "" Tagbar:
" nnoremap ,t :TagbarOpen<CR>
" nnoremap ,s :TagbarShowTag<CR>
" nnoremap <leader>[ :TagbarToggle<CR>

"" Completion / SuperTab:
let g:SuperTabDefaultCompletionType = 'context'
set completeopt+=menuone,longest

" Header insert in h,hpp
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef __" . gatename . "__"
  execute "normal! o#define __" . gatename . "__"
  execute "normal! Go#endif // __" . gatename . "__"
  normal! ko
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" enable :make
au BufEnter *.scala compiler scala
" :scala --> !scala %
cnoreabbrev <expr> scala getcmdtype()==':'&&getcmdline()=~#'^scala'?'!scala %':'scala'

" Remap Caps Lock to ESC
let hasMac = has('unix') && system("uname") == "Darwin\n"
if has('unix') && !hasMac
silent !whereis xmodmap && xmodmap -e "clear lock" -e "keycode 0x42 = Escape"
endif

" Various mapping to set indent
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=8 softtabstop=4 shiftwidth=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
