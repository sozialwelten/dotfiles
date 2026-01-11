" ============================================================================
" VIM CONFIGURATION
" ============================================================================

" ----------------------------------------------------------------------------
" Plugin Management (vim-plug)
" ----------------------------------------------------------------------------
call plug#begin()

" Theme
Plug 'kadekillary/skull-vim'

" File Explorer & Fuzzy Finding
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status Line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git Integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Coding Helpers
Plug 'tpope/vim-commentary'    " Kommentieren mit gc
Plug 'tpope/vim-surround'      " Klammern/Quotes bearbeiten
Plug 'jiangmiao/auto-pairs'    " Auto-Close Klammern

" Syntax & Language Support
Plug 'sheerun/vim-polyglot'    " Viele Sprachen

" Python Specific
Plug 'vim-python/python-syntax'
Plug 'dense-analysis/ale'      " Linting & Fixing

call plug#end()

" ----------------------------------------------------------------------------
" General Settings
" ----------------------------------------------------------------------------
set nocompatible              " Vim-Modus (kein Vi)
filetype plugin indent on     " Filetype Detection
syntax on                     " Syntax Highlighting

" Zeilennummern
set number relativenumber     " Absolute + relative Nummern

" Suche
set ignorecase                " Groß-/Kleinschreibung ignorieren
set smartcase                 " ... außer bei Großbuchstaben
set incsearch                 " Inkrementelle Suche
set hlsearch                  " Suchergebnisse highlighten

" Interface
set mouse=a                   " Maus-Unterstützung
set cursorline                " Aktuelle Zeile hervorheben
set signcolumn=yes            " Spalte für Zeichen immer anzeigen
set laststatus=2              " Statuszeile immer anzeigen
set showcmd                   " Kommandos anzeigen
set wildmenu                  " Besseres Kommando-Completion
set wildmode=longest:full,full
set splitbelow                " Horizontale Splits unten
set splitright                " Vertikale Splits rechts

" Performance
set hidden                    " Buffer im Hintergrund
set updatetime=300            " Schnellere Updates
set timeoutlen=500            " Timeout für Mappings
set lazyredraw                " Nicht während Makros neuzeichnen

" Backup & Swap
set nobackup                  " Keine Backup-Dateien
set nowritebackup
set noswapfile

" Undo
set undofile                  " Persistentes Undo
set undodir=~/.vim/undodir    " Undo-Verzeichnis
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" Farben
set termguicolors             " True Color Support
set background=dark
" Farbschema nur laden, wenn es existiert
try
    colorscheme skull-vim
catch
    colorscheme default
endtry

" ----------------------------------------------------------------------------
" Indentation & Formatting
" ----------------------------------------------------------------------------
set expandtab                 " Tabs zu Spaces
set tabstop=4                 " Tab-Breite
set shiftwidth=4              " Indent-Breite
set softtabstop=4
set autoindent                " Auto-Einrückung
set smartindent               " Intelligente Einrückung

" Python PEP 8
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" ----------------------------------------------------------------------------
" Clipboard
" ----------------------------------------------------------------------------
set clipboard=unnamedplus     " System-Zwischenablage

" ----------------------------------------------------------------------------
" Leader Key
" ----------------------------------------------------------------------------
let mapleader = " "
let maplocalleader = " "

" ----------------------------------------------------------------------------
" Key Mappings
" ----------------------------------------------------------------------------

" Schnelles Speichern und Beenden
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Navigation zwischen Splits
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Split-Größe ändern
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" Buffer Navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" Tab Navigation
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>to :tabonly<CR>

" Suche deaktivieren
nnoremap <leader>h :nohlsearch<CR>

" Zeilen verschieben
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Besseres Einrücken im Visual Mode
vnoremap < <gv
vnoremap > >gv

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>ef :NERDTreeFind<CR>

" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>l :Lines<CR>

" Git (Fugitive)
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>

" Kommentieren (Commentary)
" Nutze: gc in Visual Mode oder gcc für eine Zeile

" ----------------------------------------------------------------------------
" Plugin Settings
" ----------------------------------------------------------------------------

" NERDTree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\.pyc$', '__pycache__']

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='distinguished'

" Python Syntax
let g:python_highlight_all = 1

" ALE (Linting)
let g:ale_linters = {
\   'python': ['flake8', 'pylint'],
\}
let g:ale_fixers = {
\   'python': ['black', 'isort'],
\}
let g:ale_fix_on_save = 0  " Setze auf 1 für auto-fix beim Speichern
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
nnoremap <leader>af :ALEFix<CR>

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" FZF
let g:fzf_layout = { 'down': '~40%' }

" ----------------------------------------------------------------------------
" AutoCommands
" ----------------------------------------------------------------------------

" Cursor Position beim Öffnen wiederherstellen
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

" Trailing Whitespace highlighten (nach jedem Colorscheme-Wechsel neu setzen)
augroup highlight_whitespace
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * if &modifiable | match ExtraWhitespace /\s\+$/ | endif
    autocmd InsertEnter * if &modifiable | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
    autocmd InsertLeave * if &modifiable | match ExtraWhitespace /\s\+$/ | endif
augroup END

" Initiales Setzen der Highlight-Gruppe
highlight ExtraWhitespace ctermbg=red guibg=red

" Python-spezifische Settings
autocmd FileType python setlocal colorcolumn=80,120

" ----------------------------------------------------------------------------
" Ende der Konfiguration
" ----------------------------------------------------------------------------
