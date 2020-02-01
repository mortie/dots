call plug#begin()
Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'arakashic/chromatica.nvim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
call plug#end()

" Switches
syntax on
set nu
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
au BufNewFile,BufRead *.vue setlocal filetype=html

" Chromatica
let g:chromatica#libclang_path = '/usr/lib/llvm-9/lib/libclang.so'
let g:chromatica#responsive_mode = 1
let g:chromatica#enable_at_startup = 1

" CtrlP
" (ctrl+l is ctrl+p with dvorak, and p is a bit far away...)
let g:ctrlp_map = '<c-l>'

" vim-go
let g:go_highlight_diagnostic_errors = 0

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
