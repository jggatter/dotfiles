" .vimrc - James Gatter
"
" Inspired by the following github users
" 	@threkk
" 	@theprimeagen
"
"

let is_nvim = has('nvim')

if is_nvim
    let $BASE = stdpath('config')
else
    let $BASE = '$HOME/.vim'
endif

call plug#begin($BASE.'/plugged')
    Plug 'rakr/vim-one' 
    Plug 'folke/tokyonight.nvim'
    Plug 'morhetz/gruvbox'
call plug#end()

" Common and plugins
source $BASE/common.vim
source $BASE/plugins.vim

" Language support
" source $BASE/languages/python.vim

if is_nvim
    " General
    lua require('other')

    " Languages
    "lua require('languages.python')

else
    source $BASE/only_vim.vim
endif
