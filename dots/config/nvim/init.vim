call plug#begin()
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
call plug#end()

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

" Terminal windows shouldn't have numbers
augroup TerminalStuff
	au!
	autocmd TermOpen * setlocal nonumber
augroup END

" Hotkeys
tnoremap <C-w> <C-\><C-n><C-w>
inoremap <C-w> <C-\><C-n><C-w>
vnoremap <C-w> <C-\><C-n><C-w>

" Highlights
hi Whitespace ctermfg=darkgrey
hi ColorColumn ctermbg=black

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

" Chromatica
let g:chromatica#libclang_path = '/usr/lib/llvm-9/lib/libclang.so'
let g:chromatica#responsive_mode = 1
let g:chromatica#enable_at_startup = 1

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

" netrw
let g:netrw_liststyle = 3
autocmd FileType netrw setlocal bufhidden=delete

" Clipboard using xclip and xwayland works way better than wl-{copy,paste}
let g:clipboard = {
	\ 'name': 'xclipboard',
	\ 'copy': {
		\ '+': 'xclip -i -selection clipboard',
		\ '*': 'xclip -i -selection primary',
	\ },
	\ 'paste': {
		\ '+': 'xclip -o -selection clipboard',
		\ '*': 'xclip -o -selection primary',
	\ },
\ }
