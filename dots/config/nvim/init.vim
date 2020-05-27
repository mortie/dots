call plug#begin()
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
call plug#end()

function CocPlugInstall()
	CocInstall coc-clangd
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
