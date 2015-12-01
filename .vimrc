set tabstop=4           " Tab counts as 4 spaces
set softtabstop=4       " Soft tabs ARE 4 spaces
set shiftwidth=4        " Autoindent using 4 spaces
set expandtab           " Expand tabs to spaces
syntax enable
set background=dark
set backspace=indent,eol,start
colorscheme robokai
vmap > >gv
vmap < <gv
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
filetype plugin indent on
set rtp+=/usr/share/vim/vimfiles
autocmd BufNewFile,BufReadPost *.go set filetype=go
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
" Set a color column so you know when you get to the end of the line
" set colorcolumn=80
" highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
