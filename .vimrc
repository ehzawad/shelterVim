set nocompatible
" long live vim
set encoding=utf-8
set secure
" When writing buffer encoding to utf-8
set fileencoding=utf-8
set ff=unix
" Script Encoding When writing to buffer
scriptencoding utf-8

filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug 'Chiel92/vim-autoformat'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'terryma/vim-multiple-cursors'
Plug 'szw/vim-g'
Plug 'tomtom/tcomment_vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'majutsushi/tagbar'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'jacoborus/tender'
Plug 'othree/html5.vim'
Plug 'tpope/vim-surround'
Plug 'Valloric/YouCompleteMe', { 'do': 'python3.6 ./install.py --clang-completer --tern-completer' }

call plug#end()

" syntax highlighting and auto-indentation
syntax on
set infercase
set ai
set si
set nu

" omg folding is the worst
" but sometimes useful for hiding details
" set nofoldenable

" omg automatic comment insertion is the worst
set formatoptions-=cro
autocmd FileType *  setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" expand tabs to 4 spaces
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab

set completeopt+=longest        " Only insert longest common string
set pumheight=8                 " Limit height of popup menu

" shortcuts to common commands
" you can use leader whatever you want
let mapleader = ","

" faster tab navigation
" gt gT
" :tabs     will show you all tabs list
" :tabf :tabl :tabp :tabN is really handy
" buffers is more intutive use arrow keys ..SO mapping
" hacky way tab browsing 2gt
" <C-o. and <C-i> is really helpful
" always show tab line to avoid annoying resize
set showtabline=2

" searching options
set incsearch
set ignorecase
set smartcase

" Enable extended regexes
set magic

" Ignore stuff that can't be opened
set wildignore+=tmp/**
set wildignore+=~/.vim/view/**

" disable backups
set nobackup
set nowritebackup
set noswapfile

" font options
set background=dark
set t_Co=256

" keep at least 5 lines below the cursor
set scrolloff=5

" window options
set showmode
set showcmd
set ruler
set ttyfast
set backspace=indent,eol,start
set laststatus=2

" enable mouse support
set mouse=a

" cursor
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" word wrapping
set wrap
set linebreak
set nolist

" better tab completion on commands
set wildmenu
set wildmode=list:longest,full

set wildignore+=*.pyc,__pycache__

" close buffer when tab is closed
set nohidden

" ctags
" for ctags you have to run
" ctags -R .
" in that working directory
set tags=./tags,tags;

" ,tt browse tags using ctags
nnoremap <leader>tt :TagbarToggle<CR><C-w><C-w>

" better moving between windows
" Ctrl+{h,j,k,l}: move among windows
nnoremap <C-k> <C-W>k
nnoremap <C-j> <C-W>j
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
" Toggle  between most recent window
nnoremap <C-x> <C-w>x


" ,g: ctags go to definition in new tab
" ,hz: my doc file
" ,z : Select foldmethod

cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<cr>

" you can map :new and :vnew if you like

nnoremap <silent> <leader>, o<Esc>

nnoremap <leader>nt :tabedit <c-r>=expand("%:p:h")<cr>/
nnoremap <leader>g  <C-w><C-]><C-w>T


" Cool folding function you can scale this function as per your need
" Any query email mechezawad@outlook.com
function! MyFold(...)
  if exists("a:1")
    " max foldcolumn 12
    let w:counter = a:1
    try
      let &foldcolumn=w:counter
    catch
      execute "echom '     foldcolumn value must set to Integer and max limit 12'"

      let w:counter = input('set foldcolumn = ')
      try
        let &foldcolumn=w:counter
      catch
        echom ' !!! fuck you :( parameter must be integer!'
      endtry
    endtry
  endif

  if exists("a:2")
    let w:level = a:2
    " set foldnestmax
    " vim default set to 20
    try
      let &foldnestmax=w:level
    catch
      execute "echom '    foldlevel value set to Integer and max limit 20'"

      let w:level = input('set foldlevel = ')
      try
        let &foldnestmax=w:level
      catch
        echom ' !!! fuck you :( parameter must be integer!'
      endtry
    endtry
  endif

  if exists("a:3")
    if a:3 == "all"
      let w:closeMethod = a:3
      let &foldclose=w:closeMethod
    else
      execute "echom '   set foldclose = all'"
      let w:closeMethod = input('set foldclose = ')

      if w:closeMethod == "all"
        let &foldclose=w:closeMethod
      else
        echom ' !!! fuck you :( parameter must be all!'
      endif
    endif
  else
    set foldclose=
  endif

  if exists("a:4")
    if a:4 == "all"
      let l:openMethod = a:4
      let &foldopen=l:openMethod
    else
      execute "echom '   set foldopen = all'"
      let w:openMethod = input('set foldopen = ')

      if w:openMethod == "all"
        let &foldopen=w:openMethod
      else
        echom ' !!! fuck you :( parameter must be all!'
      endif
    endif
  else
    set foldopen=
  endif

  if a:0 < 1
    set nofoldenable
    set foldcolumn=0
  endif

  if a:0 > 4
    execute " echom '       Only 4 arguments will be passed to MyFold function !'"
  endif
endfunction
command! -nargs=* MyFold call MyFold(<f-args>)
"
" Auto change directory to match current file
nnoremap ,wd :cd %:p:h<CR>:pwd<CR>

" more logical vertical navigation
nnoremap <silent> k gk
nnoremap <silent> j gj

" make copy/pasting nice
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=r
    set nonu
  else
    set mouse=a
    set nu
  endif
endfunction

" ,tm: toggle mouse support
nnoremap <leader>tm :call ToggleMouse()<CR>


augroup hellHeaven
  autocmd!
  " OmniCompletion for JS
  autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

  "Auto completion for PHP
  autocmd FileType php set omnifunc=phpcomplete#CompletePHP

  " Omni complete CSS
  autocmd FileType css set omnifunc=csscomplete#CompleteCSS
augroup END


" Only apply to .txt files...
augroup HelpInTabs
  autocmd!
  autocmd BufEnter *.txt call HelpInNewTab()
augroup END
" Only apply to help files...
function! HelpInNewTab()
  if &buftype == 'help'
    "Convert the help window to a tab...
    execute "normal \<C-W>T"
  endif
endfunction


" Interesting and Advanced vim Configuration by Damiam Conway
" Make the 81st column stand out

function! ColumnLimit(...)
  if exists("a:1")
    highlight ColorColumn ctermbg=DarkGray
    call matchadd('ColorColumn', '\%81v', 100)
  else
    set colorcolumn=
  endif
endfunction
command! -nargs=? ColumnLimit call ColumnLimit(<f-args>)

" setting personalized rulerformat
set rulerformat=%15(%c%V\ %p%%%)

" Dragging and duplicating visual-line and visual-block mode
" you can change your binding as you wish
" source : Damian conway OSCON 2013

vmap <expr> <C-h>  DVB_Drag('left')
vmap <expr> <C-l>  DVB_Drag('right')
vmap <expr> <C-j>  DVB_Drag('down')
vmap <expr> <C-k>  DVB_Drag('up')
" For Creating Duplicate
vmap <expr> <C-D>  DVB_Duplicate()

" gui configuration of gvim Graphical VIM
function! ToggleGUICruft()
  if &guioptions == 'irml'
    exec('set guioptions=irLmT')
  else
    exec('set guioptions=irml')
  endif
endfunction
command! ToggleGUICruft :call ToggleGUICruft()

" By default, hide gui menus
set guioptions=irml

" Only do this part when compiled with support for autocommands
" Enable file type detection
filetype on

" Syntax of these languages is fussy over tabs Vs spaces
augroup StabFile
  autocmd!
  autocmd FileType make set ts=8 sts=8 sw=8 noexpandtab
  autocmd FileType yaml set ts=2 sts=2 sw=2 expandtab
  autocmd FileType vim  set ts=2 sts=0 sw=2 expandtab fdm=marker fdl=0
  autocmd FileType sh   set ts=2 sts=0 sw=2 expandtab
  autocmd FileType c    set ts=4 sts=0 sw=4 expandtab
  autocmd FileType cc  set ts=4 sts=0 sw=4 expandtab
  autocmd FileType cpp  set ts=4 sts=0 sw=4 expandtab
  autocmd FileType java set ts=4 sts=0 sw=4 expandtab
  autocmd FileType php  set ts=4 sts=0 sw=4 expandtab

  " Customisations based on house-style (arbitrary)
  autocmd FileType html set ts=2 sts=2 sw=2 expandtab
  autocmd FileType css set ts=2 sts=2 sw=2 expandtab
  autocmd FileType javascript set ts=2 sts=2 sw=2 expandtab

  " for aurduino support
  " Treat .rss files as XML
  autocmd BufNewFile,BufRead *.rss setfiletype xml
  autocmd BufNewFile,BufRead *.ino setlocal ft=arduino

augroup END
" Stop that damn ex mode
nnoremap Q <nop>


" html smart indentation
" Only works in vim --noplugin mode
augroup Indent
  autocmd!
  " indent and back to same marker previously marked
  " normal is not indented al all but it indents
  autocmd BufWritePost *.scss :normal migg=G`i
augroup END

" better for .c and .cpp build and run
augroup sourceCodeC
  autocmd!
  autocmd BufWritePost  *.c  retab! 4
  autocmd FileType c nnoremap <leader>b :! make %:r<CR>
  autocmd FileType c nnoremap <leader>mb :! clang -ggdb3 -O0 -std=c11 -lm -lpthread -latomic -pedantic-errors -fcolor-diagnostics *.c -o %:r<CR>
  autocmd FileType c nnoremap <leader>nb :! clang -ggdb3 -O0 -std=c11 -lm -lpthread -latomic -Werror -Wall -pedantic-errors -fcolor-diagnostics<space>
  " remember clang refactoring tools also supports for C11
  " you can use if you like

  autocmd FileType c nnoremap <leader>ca :!clang --analyze -std=c11 -lm -lpthread -latomic -Xanalyzer -analyzer-output=text -fcolor-diagnostics %<CR>
  autocmd FileType c nnoremap <leader>cx :!clang --analyze -std=c11 -lm -lpthread -latomic -Xanalyzer -analyzer-output=text -fcolor-diagnostics<space>

  autocmd FileType c nnoremap <leader>cc :!clang-tidy % -checks=-*,clang-analyzer-* -- -std=c11<CR>
  autocmd FileType c nnoremap <leader>cs :!clang -ggdb3 -O0 -std=c11 -fsanitize=address -lm -lpthread -latomic<space>
  autocmd FileType c nnoremap <leader>r :! ./
  autocmd FileType c nnoremap <leader>rr :! ./%:r<CR>
augroup END

augroup sourceCodeCPP
  autocmd!
  autocmd FileType cc,cpp nnoremap <leader>b :! make %:r<CR>
  autocmd BufWritePost  *.cc  retab! 4
  autocmd BufWritePost  *.cpp  retab! 4
  autocmd FileType cc,cpp nnoremap <leader>mb :! clang++ -ggdb3 -O0 -std=c++14 -stdlib=libc++ -lc++abi -ldl -lm -latomic -Werror -Wself-assign -Wall -pedantic-errors -Wextra-tokens -Wambiguous-member-template -Wbind-to-temporary-copy -fcolor-diagnostics -fdiagnostics-show-template-tree -ferror-limit=33 -ftemplate-backtrace-limit=13 -lpthread -l:libmagic.so.1 *.cpp -o %:r<CR>

  autocmd FileType cc,cpp nnoremap <leader>nb :! clang++ -ggdb3 -O0 -std=c++14 -stdlib=libc++ -lc++abi -ldl -lm -latomic -Werror -Wself-assign -Wall -pedantic-errors -Wextra-tokens -Wambiguous-member-template -Wbind-to-temporary-copy -fcolor-diagnostics -fdiagnostics-show-template-tree -ferror-limit=33 -ftemplate-backtrace-limit=13 -lpthread -l:libmagic.so.1 <space>

  " clang tooling for code refacting AST LLVM
  autocmd FileType cc,cpp nnoremap <leader>ca :!clang++ --analyze -std=c++14 -lm -lpthread -latomic -stdlib=libc++ -Xanalyzer -analyzer-output=text -fcolor-diagnostics %<CR>
  autocmd FileType cc,cpp nnoremap <leader>cx :!clang++ --analyze -std=c++14 -lm -lpthread -latomic -stdlib=libc++ -Xanalyzer -analyzer-output=text -fcolor-diagnostics<space>

  autocmd FileType cc,cpp nnoremap <leader>cc :!clang-tidy % -checks=-*,clang-analyzer-* -- -std=c++14 -stdlib=libc++ -lc++abi -lpthread -lm -latomic<CR>
  " address sanitizer
  " other sanitizer can be used, but there are in your bash_profile
  autocmd FileType cc,cpp nnoremap <leader>cs :!clang++ -ggdb3 -O0 -std=c++14 -stdlib=libc++ -lc++abi -fsanitize=address -lpthread -lm -latomic<space>

  autocmd FileType cc,cpp nnoremap <leader>r :! ./
  autocmd FileType cc,cpp nnoremap <leader>rr :! ./%:r<CR>
augroup END

" Better for javac
augroup sourceCodeJava
  autocmd!
  autocmd FileType java nnoremap <leader>mb :! javac<space>
  autocmd FileType java nnoremap <leader>b :! javac %<CR>
  autocmd FileType java nnoremap <leader>r :! java %:r<CR>
augroup END

" for PHP cli mode
augroup sourceCodePHP
  autocmd!
  autocmd FileType php nnoremap <leader>r :! php<space>
  autocmd FileType php nnoremap <leader>rr :! php %<CR>
augroup END

function! JscsFix()
  "Save current cursor position"
  let l:winview = winsaveview()
  "Pipe the current buffer (%) through the jscs -x command"
  % ! jscs -x
  "Restore cursor position - this is needed as piping the file"
  "through jscs jumps the cursor to the top"
  call winrestview(l:winview)
  redraw!
endfunction
command! JscsFix :call JscsFix()

" Better for JS
augroup sourceCodeJS
  autocmd!
  autocmd FileType javascript nnoremap <leader>r :! node %<CR>
  autocmd FileType javascript nnoremap <leader>ja :call JscsFix()<CR>:w<CR>
  " JscsFix command just before the buffer is written for *.js files"
  " autocmd bufwritepre *.js JscsFix
augroup END

" Better for TS
augroup sourceCodeTS
  autocmd!
  autocmd FileType typescript nnoremap <leader>r :! node %:r.js<CR>
augroup END

augroup SourceEnding
  autocmd!
  set list
  set listchars=tab:>.,trail:.,extends:#,nbsp:.
augroup END

" cursorline
" set cursorline

" Match angle bracket
set matchpairs+=<:>

set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-10.3n\                      " buffer number
set statusline+=%f\                          " file name
" set statusline=[%t]                        " only current tail filename
set statusline=[%F]                        " full path name
set statusline+=(%n)                         " show the number of buffer
set statusline+=%{HasPaste()}
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'}]  " filetype
set statusline+=%=                           " right align
set statusline+=%{synIDattr(synID(line('.'),col('.'),1),'name')}\  " highlight
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
" Returns true if paste mode is enabled
function! HasPaste()
  if &paste
    return 'PASTEmode'
  endif
  return ''
endfunction

" Escape key alteration
inoremap kj <esc>

" repoen a file at the same line it was on when previously closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
      \| exe "normal! g'\"" | endif


" supporting undo and history level
set undolevels=5000
set history=1000

" promt user Confirmation
set confirm

" autoread and autowrite from outside buffer
" default is off but for sanity
" set autoread
set noautowrite

" Indenting PARADIGM

set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks

nnoremap <silent> >> :call ShiftLine()<CR>|               "And no shift magic on comments

function! ShiftLine()
  set nosmartindent
  normal! >>
  set smartindent
endfunction

" vimdiif instantiates in different colorscheme
if &diff
  colorscheme tender
endif

" diff with file itself
command DiffOrig vert new | set bt=nofile | r ++edit # | 0d | diffthis | wincmd p | diffthis


au FilterWritePre * if &diff | colorscheme tender | endif

" By default, vim thinks .md is Modula-2.
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" ,nn for rename the current buffer
" RENAME CURRENT FILE
" set filetype will update also according to new filename extension
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':write ' . new_name
    exec ':edit ' . new_name
    exec ':silent !rm ' . old_name
    exec ':filetype detect'
    exec ':call DeleteHiddenBuffers()'
    exec ':w'
    redraw!
  endif
endfunction
command! RenameFile :call RenameFile()

nnoremap <Leader>nn :call RenameFile()<cr>

" Disable K looking stuff up
nnoremap K <Nop>
vnoremap K <Nop>

"  >>>highlight cursorcolumn and cursorline and statusline and tabline

" highlight Tabline term=bold ctermfg=black ctermbg=yellow
highlight StatusLine term=bold  ctermfg=black ctermbg=101
" highlight StatusLineNC term=bold  ctermfg=2 ctermbg=black
" highlight CursorLine term=bold cterm=NONE
highlight cursorcolumn term=bold ctermfg=cyan ctermbg=black

" NERDtreetab toggle using ,l.. In tmux use nterw file browser if needed
nnoremap <silent><leader>l :MyNerdTree<cr>
" Open NERDTree in the directory of the current file (or /home if no file is open)
" http://superuser.com/questions/195022/vim-how-to-synchronize-nerdtree-with-current-opened-tab-file-path"
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction
command! MyNerdTree call NERDTreeToggleInCurDir()

" NERDtree for fancy look
let g:NERDTreeDirArrows=0

" NERDtree gui vim
let g:nerdtree_tabs_open_on_gui_startup=0

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright


" Allow stylesheets to autocomplete hyphenated words
autocmd FileType css,scss,sass setlocal iskeyword+=-

set title

" ; is better than :
" nnoremap ; :

" Use the system clipboard for yank / delete / paste operations
if has('unnamedplus')
  " " System CLipboard and vim registers
  set clipboard=unnamedplus
  " set clipboard=unnamed
endif

" ensure line numbers are viewable in translucent terminal windows
highlight LineNr ctermfg=darkgray ctermbg=blue

" disable annoying beep on errors
set noerrorbells
if has('autocmd')
  autocmd GUIEnter * set vb t_vb=
endif

" Remove ALL autocommands to prevent them from being loaded twice.
if has('autocmd')
  autocmd!
endif

" We love syntax highlighting.
if has('syntax')
  syntax enable
endif

" automatically create undo directory for persistent undo AWESOME
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/tmp')
  " Create dirs
  call system('mkdir ' . vimDir)
  call system('mkdir ' . myUndoDir)
  let &undodir = myUndoDir
  set undofile
endif

" view director for save your previous view
let myViewDir = expand(vimDir . '/view')
" Create dirs
call system('mkdir ' . vimDir)
call system('mkdir ' . myViewDir)
let &viewdir = myViewDir

" store all view files here
set viewdir=~/.vim/view

silent !mkdir -p ~/.vim/myTags > /dev/null 2>&1
silent !mkdir -p ~/.vim/mySpell > /dev/null 2>&1

" If you only want to save the current tab page:
set sessionoptions-=tabpages
" If you don't want help windows to be restored:
set sessionoptions-=help
" automatically save and open views (folds)
" Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=buffers
" Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=options

" set viewoptions-=options

augroup vimrc
  autocmd BufWritePost *
        \   if expand('%') != '' && &buftype !~ 'nofile' && &buftype !~ 'readonly'
        \|      mkview
        \|  endif
  autocmd BufRead *
        \   if expand('%') != '' && &buftype !~ 'nofile' && &buftype !~ 'readonly'
        \|      silent loadview
        \|  endif
augroup END

" this will only work in Gui Vim
highlight Folded guibg=grey guifg=cyan
highlight Foldcolumn guibg=darkgray guifg=white


" Automatically removing all trailing whitespace

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Speed up viewport scrolling
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>


" JSON
augroup filetype_json
  autocmd!
  au BufRead,BufNewFile *.json set ft=json syntax=javascript
  au FileType javascript setlocal suffixesadd=.js
augroup END

"
" Search and replace word under cursor ,*
nnoremap <leader><space> :%s/\<<C-r><C-w>\>/
vnoremap <leader><space> "hy:%s/\V<C-r>h/


set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/*,*/\.git/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store,*~/.vim/view/*

set wildignorecase

set wildignore+=*.o,*.out,*.obj
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.7z
set wildignore+=*.swp

" Force vim to use 'very magic' mode for regex searches
" nnoremap / /\v
"
" Clear highlights search
" highlight using  ,hh
nnoremap <silent><expr> <Leader>hh (&hls && v:hlsearch ? ':set nohls' : ':set hls')."\n"

nnoremap <leader>tn :call ToggleNumber()<CR>

set cursorline number

function! ToggleNumber()
  if (&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
command! ToggleNumber :call ToggleNumber()


" config for better move to block
runtime macros/matchit.vim

"Square up visual selections...
set textwidth=0
set virtualedit=insert

"Don't page long listings
set nomore

" Inverse highlighting for cursor...
highlight CursorInverse   term=inverse ctermfg=black ctermbg=white

" Easier mappings for resizing windows
nnoremap <C-w>< 5<C-w><
nnoremap <C-w>> 5<C-w>>
nnoremap + 5<C-w>+
nnoremap _ 5<C-w>-

" Make it easier to paste in insert mode
inoremap PPP <Esc>pa

" Index ctags from any project directories
function! ReindexCtags(...)
  let l:ctags_hook = '$(git rev-parse --show-toplevel)/.git/hooks/ctags'

  if exists(l:ctags_hook)
    exec '!'. l:ctags_hook
  else
    exec "!ctags -R ."
  endif

endfunction
command! -nargs=0 ReindexCtags call ReindexCtags(<f-args>)


" turn off vim-markdown folding
" let g:vim_markdown_folding_disabled=1

nnoremap <Leader>ct :!ctags --sort=yes -f tags %<CR>

" set, text wrapping toggles
nnoremap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
" useful for Git merge workflow for larger file
nnoremap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>



command! Q q " Bind :Q to :q
command! Qall qall
command! QA qall
command! E e
command! W w
command! Wq wq

set switchbuf+=usetab,newtab


" autocomplete

set completeopt=menu,preview



function! ToggleErrors()
if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
    Errors
  else
    lclose
  endif
endfunction

" toggle between systastic errors
nnoremap <silent> <leader>te :<C-u>call ToggleErrors()<CR>

" Merge a tab into a split in the previous window
" Merge between two tabs
function! MergeTwoTabs()
  if tabpagenr() == 1
    return
  endif
  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev

    split
    execute "buffer " . bufferName
  endif
endfunction
command! MergeTwoTabs :call MergeTwoTabs()

nmap <leader>mt :call MergeTwoTabs()<CR>

" Magically build interim directories if necessary
" thanks to  Author: Damian Conway
function! AskQuit (msg, options, quit_option)
  if confirm(a:msg, a:options) == a:quit_option
    exit
  endif
endfunction

function! EnsureDirExists ()
  let required_dir = expand("%:h")
  if !isdirectory(required_dir)
    call AskQuit("Parent directory '" . required_dir . "' doesn't exist.",
          \       "&Create it\nor &Quit?", 2)

    try
      call mkdir( required_dir, 'p' )
    catch
      call AskQuit("Can't create '" . required_dir . "'",
            \            "&Quit\nor &Continue anyway?", 1)
    endtry
  endif
endfunction

augroup AutoMkdir
  autocmd!
  autocmd  BufNewFile  *  :call EnsureDirExists()
augroup END

" assembly language syntax highlighting
au BufRead,BufNewFile *.asm set filetype=nasm

" find recursively relative path though your project folder
" like tree Data Structure
set path=$PWD/**
set path+=$HOME/**
set path+=**
set path-=~/.npm-global/
set path-=~/.npm/
set path-=~/.vim/**
set path-=~/.vim/plugged/

" " Damian Conway's  Blink function
nnoremap <silent> n n:call HLNext(0.1)<cr>
nnoremap <silent> N N:call HLNext(0.1)<cr>

function! HLNext (blinktime)
  let target_pat = '\c\%#'.@/
  let ring = matchadd('ErrorMsg', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 2000) . 'm'
  call matchdelete(ring)
  redraw
endfunction


" Make sure you have installed clang-format in your system
" clang format integrating in Vim for Ubuntu derivtives
" OS X user must change the path
" For OS X most probable path
"/usr/local/share/clang-3.X/clang-format.py
" DOCS

augroup Clang-format
  " Clear old autocmds in group
  autocmd!
  " you have config your own style .clang-format
  " Clang Forma also work for Objective C JAVA
  " Clang-formating the current buffer I am following apple webkit standards
  " for more see official website
  autocmd FileType c,cpp,cc nnoremap <leader>cf :!clang-format -i -style=WebKit %<CR>

augroup END

"VIm autosave when loose focus
autocmd BufLeave,FocusLost * silent! wall


" vim LATEX support is added
augroup sourceLatex
  autocmd!
  autocmd FileType tex nnoremap <leader>b :! pdflatex % <CR>
  autocmd FileType tex setlocal iskeyword+=:,-
  autocmd FileType tex setlocal makeprg=pdflatex\ -file-line-error\ -interaction=nonstopmode\ %
augroup END

augroup funkyThings
  " If you prefer the Omni-Completion tip window to close when a selection is
  " made, these lines close it on movement in insert mode or when leaving insert mode
  autocmd!
  autocmd CursorMovedI *  if pumvisible() == 0|silent! pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif
  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =
augroup END


" use spelling in email and git commit messages
autocmd FileType mail,gitcommit set spell
set spellsuggest=5

" make the command mode less annoying
" Emacs(readline) binding is here
" start of line
cnoremap <C-A>     <Home>
" back one character
cnoremap <C-B>     <Left>
" delete character under cursor
cnoremap <C-D>     <Del>
" end of line
cnoremap <C-E>     <End>
" forward one character
cnoremap <C-F>     <Right>
" recall newer command-line
cnoremap <C-N>     <Down>
" recall previous (older) command-line
cnoremap <C-P>     <Up>

" Eslint JS pluggable linter
function! Eslint()
  w!
  set autoread
  silent exec "! eslint --fix ".expand('%')
  redraw!
  set noautoread
  e!
  w
endf

command! Eslint :call Eslint()
au Filetype *.jsx,js nnoremap <leader>je :silent call Eslint()<CR>
"
" C or CPP header abbreviation complete
ab #i #include
ab #d #define

" vim spell checking feature is good for editing txt file markdown or latex
if has("spell")
  set spelllang=en_us
  nnoremap  <silent> <leader>s :set spell!<CR>:echo "Spell Check: " . strpart("OffOn", 3 * &spell, 3)<CR>

endif

" " Helpful for printing as a series
" " Inspired from vim official documentation
function! Counter(...)
  if exists("a:1")
    let w:counter = a:1
  else
    let w:counter = 0
  end

  if exists("a:2")
    let w:incre = a:2
  else
    let w:incre = 1
  end

  " a:0 represent number of commandline agrv like C Language (argc)
  " a:1 represent argument vector like C Language (argv)
  if exists("a:3")
    let w:delim = a:3
  else
    let w:delim = ","
  end

  func! ListItem()
    let w:counter += w:incre
    return w:counter - w:incre . w:delim ." "
  endfunc

  func! ListReset()
    let w:counter = 0
    return ''
  endfunc

  inoremap <expr> <C-L> ListItem()
  inoremap <expr> <C-R> ListReset()
endfunction
command! -nargs=* MySeries call Counter(<f-args>)

" Better backword deletion in insert mode
inoremap <C-u> <C-g>u<C-u>
inoremap <C-w> <C-g>u<C-w>

" Better focus to line number
autocmd InsertLeave * set cursorline
autocmd InsertEnter * set nocursorline


" You can jump through the entries in that list with :lnext and :lprevious.


" back one word
inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
" delete character under cursor
inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
" end of line
" forward one character
inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"


" common type-mistakes
ab teh the

" Highlight Matched Parenthesis
hi MatchParen ctermbg=gray guibg=lightgray

" Better JUMP upwards and downwards
inoremap <C-k> <C-g>k
" remember, I have remapped <C-j> VIM's default Behavior
" NO No ..There is a default alternative of <C-j> is <C-m>
inoremap <C-j> <C-g>j

" " disable individual keys by mapping them to the special <Nop>
" " only in INSERT mode
" " for purity BUT I AM not used to
" inoremap <BS> <Nop>
" inoremap <Del> <Nop>

nnoremap  Y "+Y
nnoremap  y "+yy
nnoremap  yy "+yy
xnoremap  Y "+Y
xnoremap  y "+y

" you will forget some mapping so read key map directly from plgin folder or
" :h

"

" split WINDOW not always in EQUAL SIZE
set noequalalways
" Autocomplete with dictionary words when spell check is on

set dictionary+=/usr/share/dict/words
au FileType * execute 'setlocal dict+=~/.vim/spell/'.&filetype.'.txt'
" set dictionary+=~/.vim/spell
"

inoremap <Left>  <C-G>U<Left>
inoremap <Right> <C-G>U<Right>
inoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ?
      \ repeat('<C-G>U<Left>', col('.') - 1) :
      \ (col('.') < match(getline('.'), '\S') ?
      \     repeat('<C-G>U<Right>', match(getline('.'), '\S') + 0) :
      \     repeat('<C-G>U<Left>', col('.') - 1 - match(getline('.'), '\S')))
inoremap <expr> <End> repeat('<C-G>U<Right>', col('$') - col('.'))

" NOTE for PLUGIN usage
" see official documentation page for better use
" use * for search word under cursor
" use g* for search word under cursor
" use gv      - reselect block
" Use <C-R> for using register in Command mode or Insert mode

" abbreviation in Commad-line mode
cabb tabc tabclose
cabb tabp tabprevious
cabb Tex  Texplore

" Autoformat plugin
cabb Au Autoformat
cabb AU Autoformat

" NETRW built in Project drawer
" Quickly explore directory with Netrw, positioning cursor to the last file
" www.vimcast.org Thanks to drew nil @thoughtbot
" http://youtu.be/MGmIJyTf8pg for source of inspiration (tpope)
" press - to go into Project drawer and <CR> to enter
if !exists("g:loaded_vinegar") && empty(filter(split(&rtp, ','), "v:val =~ 'vinegar'"))
  nnoremap <silent> -  :let g:netrw_last_file = expand('%:t')<CR>
        \:Explore<CR>
        \:exec ':'.search('\V'.escape(g:netrw_last_file, '\'))<CR>
  let g:netrw_banner = 0
  let g:netrw_sort_sequence = '*,\%(' . join(map(split(&suffixes, ','), 'escape(v:val, ".*$~")'), '\|') . '\)[*@]\=$'
  " mix dotfiles with regular ones when sorting
  au FileType netrw  let g:netrw_sort_options = 'i/['.g:netrw_sepchr.'._]\+/'
        \| let g:netrw_list_hide = '^\.\.\=/\=$,^\.'
  let g:netrw_hide = 0
  " Current directory tracks the browsing directory in directory listing mode (netrw)
  let g:netrw_keepdir=0

  " Prevent some files/directories from being listed
  let g:netrw_list_hide='\.pyc$,\.pyo$,\.o$,\.swp$,^\.svn/$,^\.DS_Store$'
endif


" helper function to cycle through options
" reference: http://cs.stanford.edu/~netj/
fun! s:cycle(opt, values)
  exec "let oldValue = &". a:opt
  let idx = (index(a:values, oldValue) + 1) % len(a:values)
  let newValue = a:values[idx]
  exec "setlocal ". a:opt ."=". newValue
  exec "setlocal ". a:opt ."?"
endfun

" Fold method
nnoremap <leader>z    :call <SID>cycle("foldmethod", split("manual indent syntax"))<CR>
" Virtualedit
nnoremap <leader>ve   :call <SID>cycle("virtualedit", insert(split("all block insert onemore"), ""))<CR>

" If you want to exclude * register
" set clipboard=exclude:.*

" some by-product files
set suffixes-=.h
set suffixes+=.o,.a     " object and archive files
set suffixes+=.class    " Java classes
set suffixes+=#         " Emacs auto backups


func! LessInitFunc()
  set nocursorcolumn nocursorline nonumber
endfunc
command! LessInitFunc :call LessInitFunc()


execute "set <M-p>=\ep"
execute "set <M-P>=\eP"

" tHIS FUNction
" all credits to https://github.com/dhruvasagar
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

" case sensetative with ignore case on
" ref:  http://vi.stackexchange.com/questions/4054/case-sensitive-with-ignorecase-on
function! SearchCaseInsensetiveWithIgnore()
  nnoremap <silent>  * :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=1<CR>n
  nnoremap <silent>  # :let @/='\C\<' . expand('<cword>') . '\>'<CR>:let v:searchforward=0<CR>n
  nnoremap <silent> g* :let @/='\C'   . expand('<cword>')       <CR>:let v:searchforward=1<CR>n
  nnoremap <silent> g# :let @/='\C'   . expand('<cword>')       <CR>:let v:searchforward=0<CR>n
endfunction
command! SearchCaseInsensetiveWithIgnore call SearchCaseInsensetiveWithIgnore()

" From source
" Vim default visual search is not handy
" www.vimcast.org
" makes * and # work on visual mode too.
function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" productibility
" word, column, byte and etc.. count is easy
" vim has default wordcount() function which return in status line
" g<C-g>

nnoremap <leader>* :%s/\<<C-r><C-w>\>//gn<CR>
vnoremap <leader>* "hy:%s/\V<C-r>h//gn<CR>


" forget Undo History for the current file

fun! <SID>ForgetUndo()
  let old_ul = &undolevels
  set undolevels=-1
  exe "sil! normal a \<BS>\<Esc>"
  w
  let &undolevels = old_ul
  unlet old_ul
endfun
com! -nargs=0 ForgetUndo call <SID>ForgetUndo()

" show full definition from tag file
set showfulltag


" Save session and Load session
" source github
set ssop=buffers,sesdir,tabpages,winpos,winsize

" Never map tab . Tab is already a control key, <C-i>
"
"" Set tabstop, softtabstop and shiftwidth to the same value
" thanks to @janosgyerik
command! -nargs=* Stab call Stab()
function! Stab()
  let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
  if l:tabstop > 0
    let &l:sts = l:tabstop
    let &l:ts = l:tabstop
    let &l:sw = l:tabstop
  endif
  call SummarizeTabs()
endfunction

function! SummarizeTabs()
  try
    echohl ModeMsg
    echon 'tabstop='.&l:ts
    echon ' shiftwidth='.&l:sw
    echon ' softtabstop='.&l:sts
    if &l:et
      echon ' expandtab'
    else
      echon ' noexpandtab'
    endif
  finally
    echohl None
  endtry
endfunction
command! SummarizeTabs call SummarizeTabs()

" For debug map
" :verbose map <C-e> for example

if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" input date in different format
inoremap <silent> <C-g><C-t> <C-r>=repeat(complete(col('.'), map([ "%Y-%m-%d %H:%M:%S", "%Y-%m-%d", "%Y %b %d", "%d-%b-%y", "%a, %d %b %Y %H:%M:%S %z", "%a %b %d %T %Z %Y"], 'strftime(v:val)')), 0)<CR>


" toggle paste mode
nnoremap <leader>tp  :set invpaste<CR>

" " refresh vim window
function! RefreshUI()
    " Clear & redraw the screen, then redraw all statuslines.
    redraw!
    redrawstatus!
endfunction
command! RefreshUI call RefreshUI()

au BufWritePost * RefreshUI

set updatecount=10

" delete too many messed up hidden buffers
" From http://stackoverflow.com/a/8459043/2620402.
function! DeleteHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction
command! DeleteHiddenBuffers call DeleteHiddenBuffers()

" underline
" Vim wikia :Underline --
function! s:Underline(chars)
  let chars = empty(a:chars) ? '=' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

" Highlight settings visual selection
highlight Search ctermfg=black
highlight Visual ctermfg=233 ctermbg=67 guifg=#1b1d1e guibg=#465457

" faster escape between modes in VIM
set timeoutlen=1000 ttimeoutlen=0
" Like most of IDE highlight word

function! HighlightAllOfWord(...)
  if exists("a:1")
    au CursorMoved * silent! exe printf('match Search /\<%s\>/', expand('<cword>'))
  endif
  if a:0 < 1
    match none /\<%s\>/
  endif
endfunction
command! -nargs=? HighlightAllOfWord  call HighlightAllOfWord(<f-args>)

" etc
"   Chiel92/vim-autoformat
"

" glorious tag generate in insert mode in any file
inoremap <c-x>{ }}<esc>Bi{{

" both open and close tag generate
inoremap <c-x>< ><esc>Bi<<esc>vi>"by<esc>Ea</<C-r>b><esc>T>i<space><esc>
" just single tag for example <img src="" />
inoremap <c-x>> <space>/><esc>bbi<<esc>e

" readline style
inoremap        <C-A> <C-O>^
" last inserted text :help <c-r> for more
inoremap   <C-X><C-A> <C-A>

" python stuff
function! ModePython()
  " Disable the smartindent feature that puts # characters at the beginning of the line
  inoremap <buffer> # X<C-H>#
endfunction
command! ModePython call ModePython()

augroup pythonSmartIndent
    autocmd!
    autocmd FileType python :call ModePython()
augroup END

inoremap {<CR> {<CR>}<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap [<CR> [<CR>]<ESC>O


" Set the correct filetype for non-standard files
au BufRead,BufNewFile,BufFilePost *.cls             set filetype=tex
au BufRead,BufNewFile,BufFilePost *.nc              set filetype=nesc
au BufRead,BufNewFile,BufFilePost *.Rnw             set filetype=tex

" " remember :Texplore
" " will open netrw in new tab (viewport)

" To pick up any JavaScript and HTML keyword syntax groups while editing a PHP
" file, you can use 3 different regexs, one for each language.  Or you can
" simply restrict the include groups to a particular value, without using
" a regex string:
let g:omni_syntax_group_include_php = 'php\w\+,javaScript\w\+,html\w\+'
let g:omni_syntax_group_include_php = 'phpFunctions,phpMethods'

" The basic form of this variable is:
" let g:omni_syntax_group_include_{filetype} = 'regex,comma,separated'

" The PHP language has an enormous number of items which it knows how to syntax
" highlight.  These items will be available within the omni completion list.

let g:omni_syntax_group_exclude_php = 'phpCoreConstant,phpConstant'
let g:omni_syntax_group_exclude_php = 'php\w*Constant'


" STEAL FROM reactJS creator MACVIM box
function! s:VSplitIntoNextTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() < tab_nr
    close!
    if l:tab_nr == tabpagenr('$')
      tabnext
    endif
    vsp
  else
    close!
    tabnew
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc


function! s:VSplitIntoPrevTab()
  "there is only one window
  if tabpagenr('$') == 1 && winnr('$') == 1
    return
  endif
  "preparing new window
  let l:tab_nr = tabpagenr('$')
  let l:cur_buf = bufnr('%')
  if tabpagenr() != 1
    close!
    if l:tab_nr == tabpagenr('$')
      tabprev
    endif
    vsp
  else
    close!
    exe "0tabnew"
  endif
  "opening current buffer in new window
  exe "b".l:cur_buf
endfunc
command! VSplitIntoPrevTab call s:VSplitIntoPrevTab()
command! VSplitIntoNextTab call s:VSplitIntoNextTab()

" Use space to jump down a page (like browsers do)...
nnoremap  <Space> <PageDown>
xnoremap  <Space> <PageDown>
" use controlSpace to up a page
nnoremap <NUL> <PageUp>
xnoremap <NUL> <PageUp>


" Vim Tag scanning is so slow
set complete-=t
" Note that you can also abort the lengthy scanning by pressing  <C-c>
"

augroup pythonSource
  autocmd!
  autocmd FileType python nnoremap <leader>r :! python3 %<CR>
augroup END

" autoformat support by google
let g:formatter_yapf_style = 'google'

autocmd FileType python set omnifunc=pythoncomplete#Complete

let g:gist_open_browser_after_post = 1

if !empty(glob("~/.vim/plugged/tender"))
  colo tender
else
  colo smyck
endif


" go Link Quickly
fun! Link(site)
  if a:site == "fb"
    let l:site = "facebook.com"
  elseif a:site == "goog"
    let l:site = "google.com"
  elseif a:site == "gh"
    let l:site = "github.com"
  elseif a:site == "gist"
    let l:site = "gist.github.com"
  elseif a:site == "so"
    let l:site = "stackoverflow.com"
  elseif a:site == "sodoc"
    let l:site = "stackoverflow.com/documentation"
  elseif a:site == "tw"
    let l:site = "twitter.com"
  elseif a:site == "re"
    let l:site = "reddit.com"
  elseif a:site == "qa"
    let l:site = "quora.com"
  elseif a:site == "mdn"
    let l:site = "developer.mozilla.org"
  elseif a:site == "ke"
    let l:site = "keep.google.com"
  elseif a:site == "mail"
    let l:site = "mail.google.com"
  elseif a:site == "vim"
    let l:site = "github.com/vim/vim/releases"
  elseif a:site == "or"
   let l:site = "http://docs.oracle.com/javase/8/javase-books.htm"
  else
    let l:site = a:site
  endif

  if l:site !~? '^http\?:\/\/'
    let l:site = 'http://' . l:site
  endif
  call netrw#BrowseX(l:site, netrw#CheckIfRemote())
endfun
command! -nargs=+ -complete=command Link call Link(<q-args>)
" use case
" single website
" :Goto "github.com"
" or
" :Goto github.com
" two or multiple link
"
" :Goto "google.com github.com"
" :Goto "google.com fb.com github.com"
"
" Make netrw more useful
let g:netrw_sort_by='time'
let g:netrw_sort_direction='reverse'

" auto correct word on the fly
iab    retrun  return
iab     pritn  print
iab       teh  the
iab      liek  like
iab  liekwise  likewise

" Author Damian Conway
highlight ColorColumn ctermfg=208 ctermbg=Black

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\S', 100)
    endif
endfunction

"ale linter PLUGIN
" Disable gcc
" let g:ale_linters = {'c': []}

let g:ale_sign_error = '!'
let g:ale_sign_warning = '-'

" MyNext() and MyPrev(): Movement between tabs OR buffers {{{
function! MyNext()
    if exists( '*tabpagenr' ) && tabpagenr('$') != 1
        " Tab support && tabs open
        normal gt
    else
        " No tab support, or no tabs open
        execute ":bnext"
    endif
endfunction
command! Mynext call MyNext()

function! MyPrev()
    if exists( '*tabpagenr' ) && tabpagenr('$') != '1'
        " Tab support && tabs open
        normal gT
    else
        " No tab support, or no tabs open
        execute ":bprev"
    endif
endfunction
command! Myprev call MyPrev()
" }}}
"

" java FXML
autocmd! BufNewFile,BufRead *.fxml setf fxml

" Man
" :h man
runtime! ftplugin/man.vim
" To use a vertical split instead of horizontal
" let g:ft_man_open_mode = 'vert'

" To use a new tab
let g:ft_man_open_mode = 'tab'

" To enable folding use this
let g:ft_man_folding_enable = 1

set keywordprg=:Man

" ignore unwanted filetype
let g:ft_ignore_pat = '\.\(Z\|gz\|bz2\|class\|zip\|tgz\)$'

set modifiable

" text selection color reverse
hi Visual term=None cterm=reverse guibg=Grey
" JAVA
let java_highlight_java_lang_ids=1

" Plug 'mattn/gist-vim'
" Only :w! updates a gist.
let g:gist_update_on_write = 2
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_get_multiplefile = 1
let g:gist_edit_with_buffers = 1


augroup ShCodeJS
  autocmd!
  autocmd FileType sh nnoremap <leader>r :! bash %<CR>
augroup END

augroup sourceCodeHTML
  if has('unix') && executable('xdg-open')
    autocmd!
    autocmd FileType html nnoremap <leader>r :!xdg-open %<CR><CR>

  endif
augroup END

" http://stackoverflow.com/a/26551079/4009164
" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-A> :ZoomToggle<CR>

" YCM Vim
augroup load_ycm
  autocmd!
  autocmd CursorHold, CursorHoldI * :packadd YouCompleteMe
                                \ | autocmd! load_ycm
augroup END

let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" terryma/vim-multiple-cursors
let g:multi_cursor_next_key='<C-s>'

command! W w !sudo tee % > /dev/null
