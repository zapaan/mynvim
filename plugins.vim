set runtimepath+=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim
" Begdein
let g:dein#auto_recache = 1
if dein#load_state(config_dir . '/dein')
  call dein#begin(config_dir . '/dein')
  " Let dein manage dein
  call dein#add(config_dir . '/dein/repos/github.com/Shougo/dein.vim')
  " Plugins
  call dein#add('morhetz/gruvbox')
  call dein#add('Yggdroot/indentLine')
  call dein#add('vim-airline/vim-airline')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-commentary')
  "call dein#add('jiangmiao/auto-pairs')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('cespare/vim-toml')
  " Finder
  call dein#add('Yggdroot/LeaderF')
  " Completion
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-jedi')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('ncm2/float-preview.nvim')
  
  " Last
  call dein#add('ryanoasis/vim-devicons')
  " Endein
  call dein#end()
  call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif
command RemoveUnusedPlugins call map(dein#check_clean(), "delete(v:val, 'rf')")

" gruvbox
" autocmd vimenter * ++nested colorscheme gruvbox
colorscheme gruvbox

" On start, if in git repo, cd to its root
autocmd VimEnter * silent! Gcd

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" LeaderF
let g:Lf_ShowDevIcons = 1
" Use arrows to move
let g:Lf_CommandMap = {'<C-K>': ['<Up>'], '<C-J>': ['<Down>']}
" Refresh cache on startup
let g:Lf_UseCache = 0
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = {'left': "\ue0b0", 'right': "\ue0b2"}
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0}

" deoplete
" hide all those useless messages in command line
set shortmess+=c
let g:deoplete#enable_at_startup = 0
autocmd InsertEnter * call deoplete#enable()
let g:deoplete#sources#jedi#enable_short_types = 1
let g:deoplete#sources#jedi#show_docstring = 1
call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
" Autoclose preview
" no need with float-preview
"autocmd CompleteDone,InsertLeave * silent! pclose!

" float-preview
set completeopt-=preview
let g:float_preview#docked = 0
"let g:float_preview#max_height
let g:float_preview#max_width = 108

" jedi
let g:jedi#completions_enabled = 0
" let g:jedi#use_splits_not_buffers = "left"

" editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
