" ===== BASIC OPTIONS =====
runtime macros/matchit.vim
runtime bundle/vim-pathogen/autoload/pathogen.vim
set autoindent
set backspace=eol,indent,start
set backupskip=/tmp/*,/private/tmp/*"
set expandtab
set foldcolumn=0
set hidden
set hlsearch
set laststatus=2
set modeline
set modelines=2
set nocompatible
set nofoldenable
set nosmartindent
set nosmarttab
set nospell
set number
set numberwidth=4
set pastetoggle=<F6>
set scrolloff=3
set shiftwidth=4
set shortmess=a
set showmatch
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=80
set viminfo+=%
set wildmenu
set wildmode=longest:full,list:full
set wrap
set incsearch

" Required to use the 'pathogen' vim plugin manager
call pathogen#infect()
call pathogen#helptags()

" Tagbar Options
let g:tagbar_usearrows = 1
nnoremap <leader>l :TagbarToggle<CR>
let g:tagbar_type_tex = {
            \ 'ctagstype' : 'latex',
            \ 'kinds'     : [
            \ 's:sections',
            \ 'g:graphics:0:0',
            \ 'l:labels',
            \ 'r:refs:1:0',
            \ 'p:pagerefs:1:0'
            \ ],
            \ 'sort'    : 0,
            \ }

" XML Folding
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

syntax enable

" Turn on solarized colorscheme
set background=light
colorscheme solarized


" Pressing space after a search will clear all highlighting
nmap <SPACE> <SPACE>:noh<CR>

" filetype
filetype on
filetype indent on
filetype plugin on

" Set status line format
set statusline=%F%m%r%h%w\ (%Y)\ %=\ r%l,\ c%v\ [%p%%]

function! SetFormatOptions()
    set fo+=1 " don't break lines after 1-letter words
    set fo+=2 " use 2nd paragraph line for indent
    set fo+=l " don't auto-break long lines
    set fo+=o " auto instert comment leader on O or o
    set fo+=q " allow gq for formatting comments
    set fo+=r " auto-instert comment leader on <Enter>
    set fo-=c " don't auto-wrap comments
    set fo-=t " don't auto-wrap text
endfunction
call SetFormatOptions()

" Vim overwrites formatoptions, so we have to tell it to set these after it has
" already loaded everything
autocmd VimEnter * call SetFormatOptions()

" Nicer TODO coloring (red FG, no annoying BG color)
highlight Todo ctermfg=1 ctermbg=None cterm=bold

" Only have cursorline in the current buffer
" highlight CursorLine cterm=underline
set cursorline
augroup cursorlines
    autocmd BufEnter * setlocal cursorline
    autocmd BufLeave * setlocal nocursorline
    autocmd BufWinEnter * setlocal cursorline
    autocmd BufWinLeave * setlocal nocursorline
    autocmd ShellFilterPost * setlocal cursorline
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

function! HighlightBadChars()
    if &modifiable
        let tabs = "\t"
        let trailingws = "\\s\\+$"
        let rightmargin = "\\%<" . (&textwidth + 3) . "v.\\%>" . (&textwidth + 1) . "v"
        let b:badcharsmatch = matchadd("ErrorMsg", tabs . "\\|" . trailingws . "\\|" . rightmargin)
    endif
endfunc
autocmd BufReadPost *.py call HighlightBadChars()

" Diff-specific setup
func! DiffSetup()
    " Original version
    set nofoldenable foldcolumn=0 number
    set nocursorline
    set readonly
    set nomodifiable

    " Switch windows
    wincmd b

    " New version
    set nofoldenable foldcolumn=0 number

    wincmd =
    winpos 0 0
endfun
if &diff
    autocmd VimEnter * call DiffSetup()
endif

" jump to last position in a file when it is opened
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" ===== PLUGIN SETTINGS =====
" TagList
nnoremap <silent> <F8> :TlistToggle<CR>
let Tlist_Show_One_File=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_WinWidth=45
let Tlist_Inc_WinWith=0

" bufexplorer
let g:bufExplorerShowRelativePath=1
let g:bufExplorerSortBy='fullpath'
let g:bufExplorerSplitVertical=1

" NERDCommenter
let NERDShutUp=1

" NERDTree
let NERDTreeIgnore=['\~$', '\.pyc$']
nnoremap <silent> <F7> :NERDTreeToggle<CR>

" FuzzyFinderTextmate
" http://github.com/jamis/fuzzyfinder_textmate
nmap <Leader>t :FuzzyFinderTextMate<CR>


" ==== FILETYPE-SPECIFIC =====
let python_highlight_space_errors=1
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python set textwidth=79
au FileType make   set noexpandtab
au FileType tex    set makeprg=pdflatex\ -interaction\ nonstopmode\ %

let g:tex_flavor='latex'
au FileType tex set sw=2

" Make gq not mangle \item lists in latex
au FileType tex set formatlistpat=^\\s*\\\\\\(end\\\\|item\\)\\>
au FileType tex set formatoptions+=n

" ==== GENERAL MAPS, ABBREVS, AND SHORTCUTS ====
" Remove all trailing whitespace with CTRL+G
nmap <C-g> :%s/\s\+$//g<CR>

iabbrev =>> →
iabbrev <<= ←

" Putting this line in a python file will start an IPython debugger
" when it is executed. Much better than pdb.set_trace()
iab ipdb# import IPython.ipapi; IPython.ipapi.make_session(); from IPython.Debugger import Tracer; Tracer()(); # XXX


" ==== SPELL CHECKING ====
map <F5> :setlocal spell! spelllang=en_us<CR>
imap <F5> <C-o>:setlocal spell! spelllang=en_us<CR>

" Easier key combo than others for formatting paragraph
nnoremap <leader>p gqap

" ================ Folds ============================

set foldmethod=syntax   "fold based on syntax highlight interp of code
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" Codequality Integration from DevWiki
" ====================================
" Relies on Jenan Wise's codequality being installed

au FileType python set makeprg=codequality\ %
" Turn off line numbering for the error buffer
au BufReadPost quickfix setlocal nonumber

" F4: run the make program
nmap <F4> :make<CR>
vmap <F4> <C-o>:make<CR>

" F1: close the error window
nmap <F1> :cclose<CR>
imap <F1> <C-o>:cclose<CR>

" F2/F3: move between errors
nmap <F2> :cprev<CR>
nmap <F3> :cnext<CR>
imap <F2> <C-o>:cprev<CR>
imap <F3> <C-o>:cnext<CR>

let g:Imap_UsePlaceHolders = 0
