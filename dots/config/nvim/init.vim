call plug#begin()
Plug 'editorconfig/editorconfig-vim'
"Plug 'yuezk/vim-js'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'lervag/vimtex'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'pangloss/vim-javascript'
Plug 'preservim/nerdtree'
Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'}
Plug 'Raku/vim-raku'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'tikhomirov/vim-glsl'
Plug 'kergoth/vim-bitbake'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'sjl/badwolf'

Plug '~/cloud/dev/osyris/vim-osyris'
call plug#end()

lua <<EOF
	require'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = true,
		},
		indent = {
			enable = true,
		},
	}
EOF

set completeopt=menu,menuone,noselect
lua <<EOF
	-- Setup nvim-cmp.
	local cmp = require'cmp'

	cmp.setup({
		snippet = {
			-- REQUIRED - you must specify a snippet engine
			expand = function(args)
				vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
				-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
				-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
				-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = 'nvim_lsp' },
			{ name = 'vsnip' }, -- For vsnip users.
			-- { name = 'luasnip' }, -- For luasnip users.
			-- { name = 'ultisnips' }, -- For ultisnips users.
			-- { name = 'snippy' }, -- For snippy users.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})
EOF

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

set background=dark
colorscheme badwolf
hi Normal ctermbg=black guibg=black

" This fixes an issue where listchars aren't highlighted by visual selection properly
hi NonText ctermbg=none guibg=none

lua <<EOF
require'lspconfig'.clangd.setup{}
require'lspconfig'.rust_analyzer.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.zls.setup{}
require'lspconfig'.pylsp.setup{}
require'lspconfig'.kotlin_language_server.setup{
	settings = {
		kotlin = {
			inlayHints = {
				typeHints = true,
			}
		}
	}
}
require'lspconfig'.kotlin_language_server.setup{}
require'rust-tools'.setup({})
EOF

nmap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<cr>
nmap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<cr>
nmap <silent> gb <C-o>
nmap <silent> gf <C-i>
nmap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
nmap <silent> gD <cmd>lua vim.lsp.buf.declaration()<cr>

" CSI-u broke some stuff, let's try to fix it
tmap <S-Space> <Space>
tmap <S-Enter> <Enter>

" This makes CSS/JS in HTML sane
let g:html_indent_script1="zero"

" Switches
syntax on
set number
set list
set listchars=tab:>·
set colorcolumn=100
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
set cindent
set cinoptions=l1:0g0N-s

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

" Fuzzy finder
"nmap <c-l> :FZF<CR>
nmap <c-l> :Telescope find_files<CR>
hi TelescopeMatching ctermfg=214

" NERDTree
command Ex NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-go
let g:go_highlight_diagnostic_errors = 0

" vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1

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
set statusline+=%#warningmsg#
set statusline+=%*
set statusline+=%=%(%l,%c%V\ %=\ %P%)

" netrw
let g:netrw_liststyle = 3
autocmd FileType netrw setlocal bufhidden=delete
