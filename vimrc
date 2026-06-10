set nocompatible
filetype off


:color desert
filetype plugin indent on
syntax on

set ttyfast
set noerrorbells
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set cursorline
set colorcolumn=100
set wildmenu
set autowrite
set autoread
set statusline+=%F
set number
set statusline+=%F
set laststatus=2

set tags=tags;

" --- LSP (vim-lsp + vim-lsp-settings) ---
" Nix support is provided by the `nil` language server, auto-detected on PATH.
let g:lsp_settings_filetype_nix = ['nil']
let g:lsp_diagnostics_echo_cursor = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K  <plug>(lsp-hover)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
endfunction

augroup lsp_install
    autocmd!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
