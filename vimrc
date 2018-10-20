""" Coloring
syntax on
colorscheme gruvbox
set number
set termguicolors
highlight Normal ctermfg=grey ctermbg=darkblue

""" Other config
set encoding=UTF-8
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ai " Autoindent
set si " Smartindent
set wrap " Wrap lines
set tabstop=4 shiftwidth=4 
" au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif " Return to last edit position
set lazyredraw
set ttyfast

""" Mappings
" Better window switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" Better tab switching
map <C-t><left> :tabn<cr>
map <C-t><right> :tabN<cr>
