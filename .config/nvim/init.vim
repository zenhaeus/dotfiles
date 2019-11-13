" ------------------------------
" Mappings
" ------------------------------

" Toggle Spell Check
map <F5> :setlocal spell! spelllang=en_us<CR>

" Compile latex
map <Leader>ml :w <CR> :!pdflatex %<CR><CR>
" execute make
map <C-m> :w <CR> :!make<CR><CR>
" map fzf
map <C-p> :Files <CR>


" remap Esc (ESSENTIAL!!)
imap jk <Esc>

" unhighlight last search
nnoremap <C-h> :nohl<CR>

"Move visual lines, not full lines, debatable
nnoremap j gj
nnoremap k gk

" write readonly file - YAAY!!
cmap w!! w !sudo tee > /dev/null %

" Moving between splits
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h

" Toogle relative numbers in normal mode
nmap <F3> :exec &nu==&rnu? "se nu!" : "se rnu!"<CR>


" Moving between buffers
" noremap <Leader>l :ls<CR>
noremap <Leader>b :bp<CR>
noremap <Leader>n :bn<CR>

" ------------------------------
" Settings
" ------------------------------

" configure line numbers
set number

set showcmd
" Show mode in status line
set showmode
set ruler
set cursorline

" Enable syntax coloring
filetype plugin on
syntax on

set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4
" Show whitespace
set list
set listchars=eol:⏎,tab:␉·,trail:~,extends:>,precedes:<

" broken lines continue where line above starts
set breakindent

set hlsearch
set clipboard=unnamed


" enable folding
set foldmethod=syntax
set foldlevelstart=2

" ------------------------------
" Variables
" ------------------------------

" Set leader key
let mapleader=","
let maplocalleader="-"

" Foldings
let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" ------------------------------
" Plugins
" ------------------------------
" vim-plug
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')
" Make sure you use single quotes
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-online-thesaurus'

Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf.vim'
Plug '/usr/bin/fzf'

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-fugitive'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-pyclang'
Plug 'ncm2/ncm2-gtags'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-jedi'

Plug 'w0rp/ale'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ludovicchabant/vim-gutentags'
Plug 'majutsushi/tagbar'
Plug 'davidhalter/jedi-vim'

Plug 'lervag/vimtex'
Plug 'derekwyatt/vim-scala'
Plug 'jalvesaq/Nvim-R'
Plug 'dansomething/vim-eclim'
Plug 'mattn/emmet-vim'
Plug 'cjrh/vim-conda'
Plug 'vim-python/python-syntax'
Plug 'tomasr/molokai'

call plug#end()

" ------------------------------
" Configure Plug-ins
" ------------------------------
"
" Nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>

" Tagbar <- this is amazing
nnoremap <Leader>t :TagbarToggle<CR>

" nvim completion manager
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c

" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>


" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" ALE config
let g:ale_c_parse_makefile = 1

" Disable Jedi-vim autocompletion and enable call-signatures options
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"

" Python Syntax
let python_highlight_all=1

" Molokai
colorscheme molokai

" Vimtex

" zathura forward search
let g:vimtex_view_method = 'zathura'

" fix slow vimtex performance
" TODO: does not seem to work, investigate further
let g:vimtex_fold_manual = 1

" Ultisnip expand configuration
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" Airline
let g:airline_powerline_fonts = 1

" Eclim
let g:EclimCompletionMethod = 'omnifunc'
