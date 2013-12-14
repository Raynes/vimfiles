call pathogen#infect()
set wildmode=longest,list,full
set wildmenu
syntax on
filetype plugin indent on

nmap <D-0> :set gfn=Menlo:h11<CR>

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
if has('python')
function! LoadRefheapToken()
python << EOF
import os.path
import yaml
import vim
config = yaml.load(open(os.path.expanduser('~/.refh.yml')).read())
token = config['token']
user = config['user']
vim.command("let g:refheap_token='" + token + "'")
vim.command("let g:refheap_username='" + user + "'")
EOF
endfunction

call LoadRefheapToken()
endif

" Allow <Leader>! to add bang to previous command.
nnoremap <Leader>! q:kWgea!<CR>

" Fucking swp files.

set backupdir=~/.vimbackups/
set directory=~/.vimbackups/

" Statusline.

set laststatus=2
set statusline=%t\        "tail of the filename
set statusline+=%{fugitive#statusline()} " Branch.
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
set statusline+=%=      "left/right separator
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines

" Moar lispwords.

set lispwords+=GET,PUT,POST,DELETE,fact

" Incremental search.

set incsearch

" CSS shiftwidth

autocmd Filetype css setlocal shiftwidth=2

" Markdown stuff.
autocmd FileType markdown setlocal textwidth=80
autocmd FileType markdown setlocal spell spelllang=en_us

let g:clojure_align_multiline_strings = 1

" Show trailing whitespace.

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

" Fuck folding.
set nofoldenable

" No

let go_highlight_trailing_whitespace_error = 0

" Automatically format Go code on save.

autocmd FileType go autocmd BufWritePre <buffer> Fmt
