execute pathogen#infect()
" vim  {{{
let mapleader = "\ "
set scrolloff=10
syntax enable " Turn on syntax highlighting
set hidden " Leave hidden buffers open
set history=10000 "by default Vim saves your last 8 commands.
set number
set hlsearch
" map @p to paste with space
let @p='i ^[p'

" Make Y like D and C
map Y y$

" Make :#D go back automatically and :#Y like :#D
command! -range D <line1>,<line2>d|norm ``
command! -range Y <line1>,<line2>y|norm ``
:map gs i<CR>
" Prompt "(Y to save)" instead of erroring when you :q instead of :wq
set confirm

" Use while hovering over an imported variable to jump to that file and highlight the variable's name
nnoremap <leader>gf gd$hhh<C-w>gfn<CR>
" Tab Navigation {{{
nnoremap gx :tabclose<CR>
"}}}
"  Spaces and Tabs {{{
autocmd BufWritePre * %s/\s\+$//e

" New lines start in better places
set autoindent

" tabs are spaces
set expandtab

" Change number of spaces when indenting
set shiftwidth=2

" number of visual spaces per TAB
set tabstop=2

" Backspace
set backspace=indent,eol,start
" }}}

set foldenable
  " folding {{{

" open most folds by default
set foldlevelstart=0

" 10 nested fold max
set foldnestmax=10

" fold based on indent level
set foldmethod=marker
" add mappings for navigating between closed folds
nnoremap <silent> <leader>zj :call NextClosedFold('j')<cr>
nnoremap <silent> <leader>zk :call NextClosedFold('k')<cr>
function! NextClosedFold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction
" }}}

" }}}
" Plugins {{{
  " OmniSharp {{{
    let g:OmniSharp_server_stdio = 1
    filetype indent plugin on
    let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim for selector UI
    let g:OmniSharp_highlight_types = 2 "syntax highlighting with OmniSharp

    " Timeout in seconds to wait for a response from the server
    let g:OmniSharp_timeout = 5

    " Don't autoselect first omnicomplete option, show options even if there is only
    " one (so the preview documentation is accessible). Remove 'preview' if you
    " don't want to see any documentation whatsoever.
    set completeopt=longest,menuone,preview

    set previewheight=5

augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END

  " Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
  command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

  " }}}
  " Tender {{{
if (has("termguicolors"))
 set termguicolors
endif

syntax enable
colorscheme tender
" }}}
" HardTime {{{
noremap <leader>h <Esc>:call HardTimeToggle()<CR>
" }}}
" CtrlP {{{

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

let g:ctrlp_working_path_mode = 'ra'

" Ignore files & folders
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|dist'

" Display hidden files
let g:ctrlp_show_hidden = 1
" }}}

" Sneak {{{
let g:sneak#label = 1
" }}}

" ALE {{{
let g:ale_linters = { 'javascript': ['eslint', 'flow'], 'cs': ['OmniSharp'] }
" Don't run linters on opening a file

" ALE: Set up fixing
let g:ale_fixers = { 'javascript': ['eslint', 'prettier-eslint'] }
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_lint_delay = 50
" Remove garish highlighting
highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear ALEError
highlight clear ALEInfo
highlight clear ALEStyleError
highlight clear ALEStyleWarning

" Customize gutter and statusline
let g:ale_sign_error = 'X'
let g:ale_sign_warning = '?'
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'
" Map keys to navigate between lines with errors and warnings.
nnoremap <leader>[ :ALENextWrap<cr>
nnoremap <leader>] :ALEPreviousWrap<cr>
" }}}

" the silver searcher {{{
let g:ackprg = 'ag --nogroup --nocolor --column'
" }}}
" nerdtree {{{
" Open nerdtree when vim is opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Map keys to toggle nerdtree
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
" }}}

" lightline {{{
let g:lightline = {
     \ 'colorscheme': 'tender',
     \ 'active': {
     \  'right': [ ['lineinfo'] ],
     \  'left': [ ['mode'],
     \            ['gitbranch', 'relativepath', 'filename', 'modified' ] ]
     \ },
     \ 'component_function': {
     \  'gitbranch': 'fugitive#head',
     \ },
\ }
" }}}
" CSS highlighting with styled components {{{
augroup VimCSS3Syntax
  autocmd!

  autocmd FileType css setlocal iskeyword+=-
augroup END
" }}}
" }}}
" Snippets {{{
function! LocalReindent()
  normal mz
  normal 10k
  normal 20==
  normal 'z
endfunction

" Generate js function
nnoremap <leader>fun :-1read $HOME/.vim/snippets/function.js<CR>:call LocalReindent()<CR>f(a

" Generate new Promise, and then/catch blocks
nnoremap <leader>prom :read $HOME/.vim/snippets/promise.js<CR>:call LocalReindent()<CR>kJo
nnoremap <leader>then :read $HOME/.vim/snippets/then.js<CR>:call LocalReindent()<CR>f(la
nnoremap <leader>catch :read $HOME/.vim/snippets/catch.js<CR>:call LocalReindent()<CR>o

" Generate conditional blocks
nnoremap <leader>if :-1read $HOME/.vim/snippets/if.js<CR>:call LocalReindent()<CR>f(a
nnoremap <leader>else :read $HOME/.vim/snippets/else.js<CR>:call LocalReindent()<CR>kJo
nnoremap <leader>elif :read $HOME/.vim/snippets/elif.js<CR>:call LocalReindent()<CR>kJf(a

" Generate try-catch block
nnoremap <leader>try :-1read $HOME/.vim/snippets/try.js<CR>:call LocalReindent()<CR>o

" Generate loops
nnoremap <leader>forof :-1read $HOME/.vim/snippets/forof.js<CR>:call LocalReindent()<CR>f)i
nnoremap <leader>forin :-1read $HOME/.vim/snippets/forin.js<CR>:call LocalReindent()<CR>f)i
" }}}
" Custom functions {{{
" Mappings that use custom functions
nnoremap <leader>bot :call UseBottomDiff()<CR>
nnoremap <leader>top :call UseTopDiff()<CR>
nnoremap <leader>req :call JsRequire()<CR>
nnoremap <leader>log :call JsLog()<CR>
nnoremap <leader>r :call Repeat()<CR>
nnoremap <leader>flo :call Flow()<CR>

" Picks the bottom section of a git conflict
function! UseBottomDiff()
  normal /<<<
  normal d/===
  normal dd
  normal />>>
  normal dd
endfunction

" Picks the top section of a git conflict
function! UseTopDiff()
  normal /<<<
  normal dd
  normal /===
  normal d/>>>
  normal dd
endfunction

" Creates a variable and require statement, uses z registry
function! JsRequire()
  normal "zciWconst z = require('z');
endfunction

" Creates a labelled console.log, uses z registry
function! JsLog()
  normal "zciWconsole.log('z', z);
endfunction

" Move content one line up
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap <leader>j :m '>+1<CR>gv=gv
vnoremap <leader>k :m '<-2<CR>gv=gv

function! Repeat()
  normal "zyy
  normal "zp
endfunction

function! Flow()
  normal gg
  normal O
  normal i// @flow
  normal o
endfunction
" }}}
