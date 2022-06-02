nnoremap L $
nnoremap H ^
vnoremap L $
vnoremap H ^

noremap <SPACE> <Nop>
" nnoremap <SPACE> :

imap jk <ESC>
imap kj <ESC>

nmap zj o<ESC>k
nmap zk O<ESC>j


let mapleader = " "

"noremap <Esc> <nop>
nmap <S-Enter> O<Esc>
" nmap <CR> o<Esc>

" nnoremap <C-j> :m +1<CR>
" nnoremap <C-k> :m -2<CR>
" inoremap <C-j> <Esc>:m +1<CR>gi
" inoremap <C-k> <Esc>:m -2<CR>gi

" system clipboard
vmap <leader>yiw "+yiw
nmap <leader>yiw "+yiw
vmap <leader>y "+y
vmap <leader>d "_d
nmap <leader>y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P

" scrolling
nmap <leader>d <C-d>
nmap <leader>u <C-u>
vmap <leader>d <C-d>
vmap <leader>u <C-u>

" useful
nnoremap <C-A> gg<S-v>G

" copied from yaswanth's neovim
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-x> <C-w><C-x>
nnoremap <C-m> <C-w><C-m>



