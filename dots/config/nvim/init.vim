call plug#begin()
Plug 'editorconfig/editorconfig-vim'
"Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'lervag/vimtex'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'Raku/vim-raku'
Plug 'evanleck/vim-svelte', {'branch': 'main'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()

function CocPlugInstall()
	CocInstall coc-clangd
	CocInstall coc-go
	CocInstall coc-rust-analyzer
endfunc
command CocPlugInstall call CocPlugInstall()

" Switches
syntax on
set number
set list
set listchars=tab:>·
set colorcolumn=80
set inccommand=nosplit
set shiftwidth=4
set tabstop=4
set scrolloff=5
set ignorecase
set smartcase
set splitright
set splitbelow
set mouse=a
set linebreak
set breakindent
set showbreak=\ \ \ \ 

" Terminal windows are special
augroup TerminalStuff
	au!
	autocmd TermOpen * setlocal nonumber
	autocmd TermOpen * setlocal scrolloff=0
augroup END

" Hotkeys
tnoremap <C-w> <C-\><C-n><C-w>
inoremap <C-w> <C-\><C-n><C-w>
vnoremap <C-w> <C-\><C-n><C-w>

" Highlights
hi Whitespace ctermfg=darkgrey
hi ColorColumn ctermbg=black
hi Pmenu ctermfg=NONE ctermbg=black guibg=black
hi SpellRare ctermbg=NONE

" Utility functions

function Spaces(num)
	exec 'set et'
	exec 'set ts =' . a:num
	exec 'set sw =' . a:num
endfunc
command -nargs=1 Spaces call Spaces(<args>)

" File types
au BufNewFile,BufRead *.m setlocal filetype=emerald
au BufNewFile,BufRead *.m setlocal shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.vue setlocal filetype=html
au BufNewFile,BufRead *.cup setlocal filetype=cup

" CtrlP
" (ctrl+l is ctrl+p with dvorak, and p is a bit far away...)
let g:ctrlp_map = '<c-l>'

" NERDTree
command Ex NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-go
let g:go_highlight_diagnostic_errors = 0

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

" Coc stuff
set updatetime=300
let g:lsp_cxx_hl_ft_whitelist = ['c', 'cpp', 'objc', 'objcpp', 'cc', 'h', 'hh', 'hpp']

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gb <C-o>
nmap <silent> gf <C-i>

" Ctrl+left/right to switch tabs
nmap <silent> <C-Left> :tabprevious<CR>
nmap <silent> <C-Right> :tabnext<CR>

" Fix cursor for terminal mode
" https://github.com/neovim/neovim/issues/14320
" Remove once nvim is fixed upstream
autocmd FocusLost * hi TermCursor cterm=NONE ctermbg=darkgrey gui=NONE guibg=darkgrey
autocmd FocusGained * hi TermCursor cterm=reverse gui=reverse

" Swap windows with <CTRL>-w m then <CTRL>-w m
let s:markedWinNum = -1
function! MarkWindowSwap()
    let s:markedWinNum = winnr()
endfunction
function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe s:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction
function! WindowSwapping()
    if s:markedWinNum == -1
        call MarkWindowSwap()
    else
        call DoWindowSwap()
        let s:markedWinNum = -1
    endif
endfunction
nnoremap <C-w>m :call WindowSwapping()<CR>

" Status line
set statusline=
set statusline+='%f'\ %h%w%m%r\ 
set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}\ 
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)

" netrw
let g:netrw_liststyle = 3
autocmd FileType netrw setlocal bufhidden=delete
