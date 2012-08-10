set history=50
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set nobackup
set nocompatible  " Use Vim settings, rather then Vi settings
set noswapfile
set nowritebackup
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Local config
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Color scheme
colorscheme vividchalk
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Numbers
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Cucumber navigation commands
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
" :Cuc my text (no quotes) -> runs cucumber scenarios containing "my text"
command! -nargs=+ Cuc :!ack --no-heading --no-break <q-args> | cut -d':' -f1,2 | xargs bundle exec cucumber --no-color


" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Improve syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown

" Leader: set to <Space>
" Space is inserted via <C-v><Space>
" see ':h map_space' in vim for further info
let mapleader = " "


" ##################
" OMAT VIMRC-asetukset
" ##################


syntax on
set ruler
set incsearch
set ignorecase
"set shiftwidth=4
"set tabstop=4
set smartcase "ignore case when pattern contains only lower case
set title " set window title. Defaults to filename

" koodausta varten:
set smartindent 

" tarkista onko tiedostossa "modeline":
set modelines=5

"make Y to yan from the cursor to the end of line.
map Y y$ 

"alleviivaus (ei toimi)
"let u yypVr=
" päivämäärä alleviivauksella F2:sta
map <F2> o<C-R>=strftime("%d.%m.%Y")<CR><Esc>yypVr=o

hi Search ctermbg=lightgrey

"jelly on xml:ää
"au BufRead *.jelly syntax=xml

"python skeleton
autocmd BufNewFile *.py 0r ~/.vim/skeleton.py
autocmd BufEnter *.py set nosmartindent cindent

" django
autocmd BufEnter *.tmpl set syntax=django sw=2 sw=2

"use indent and plugin files for filetypes
filetype indent on
filetype plugin on

" search work directory recursively. 
" TODO Säädä tämä nyk työhakemiston mukaan, vaikka ympäristömuuttujasta
"set path=.,/usr/include,~/Documents/projects/ns-reporting/*

set wildmenu

" set tags working for Mac OS
map <C-j> <C-]>

if &diff
	hi DiffChange=3
	hi DiffText=7
endif

let &path = &path . "," . substitute($VIM_SEARCH_PATH, ':', ',', 'g')

" perl
autocmd BufNewFile *.pl 0r ~/.vim/skeleton.pl

"write file autmatically when changing buffer.
set autowrite
