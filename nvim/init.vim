let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

let mapleader = " "
filetype plugin indent on
nnoremap <silent> <Leader>uf :<C-u>Denite file<CR>
nnoremap <silent> <Leader>um :<C-u>Denite file_mru<CR>
nnoremap <silent> <Leader>ub :<C-u>Denite buffer<CR>
nnoremap <silent> <Leader>pf :<C-u>Denite file_rec<CR>
nnoremap <silent> <Leader>- gg=Gg;
nnoremap <silent> <Leader>tn :tabnew<CR>
vnoremap <silent> <C-p> "0p<CR>
map <F1> <Esc>
imap <F1> <Esc>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
set nu
set list
set listchars=tab:»-,trail:-,eol:$,extends:»,precedes:«,nbsp:%
set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
set clipboard+=unnamed
set directory=~/.config/nvim/swap
set backupdir=~/.config/nvim/backup
set undodir=~/.config/nvim/undo
set textwidth=0
set autoread
set ignorecase
set conceallevel=0
let g:vim_json_syntax_conceal = 0
nnoremap ; :
nnoremap : ;
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))
