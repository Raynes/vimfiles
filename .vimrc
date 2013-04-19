call pathogen#infect()
colorscheme Tomorrow-Night
set wildmode=longest,list,full
set wildmenu
syntax on
filetype plugin indent on

" Because I like to use the mouse in the terminal. Get over it.
set mouse=a

" I had some issues with yanked text from the terminal Vim ending
" actually ending up on my system clipboard. This makes it go there.
set clipboard=unnamed

" I don't use this as much as I thought I would. My hands
" instinctively reach for the actual keys.
nnoremap <leader>f =i(

" Because sometimes you just can't paredit.
command! Ptoggle call PareditToggle()

" Get the refheap plugin up and running.
function! LoadRefheapToken()
python << EOF
import os.path
import yaml
import vim
token = yaml.load(open(os.path.expanduser('~/.refh.yml')).read())['token']
vim.command("let g:refheap_token='" + token + "'")
EOF
endfunction

call LoadRefheapToken()

" Fix crap.
au FileType html setlocal textwidth=0
au FileType css setlocal shiftwidth=4 tabstop=4
au FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" The directory should be the current file I'm editing.
set autochdir

" Allow <Leader>! to add bang to previous command.
nnoremap <Leader>! q:kWgea!<CR>

" Fucking swp files.

set backupdir=~/.vimbackups/
set directory=~/.vimbackups/

