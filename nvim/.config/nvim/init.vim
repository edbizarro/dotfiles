call plug#begin()

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" On-demand loading
Plug 'preservim/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'dense-analysis/ale'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
call plug#end()
