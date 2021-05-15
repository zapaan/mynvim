nnoremap <Space> <Nop>
let mapleader = " "

" disable bw, don't want to accidentally wipeout a file
cabbrev bw bd

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the defaults
map Y y$

" Ctrl-s to save
" If the current buffer has never been saved, it will have no name,
" call the file browser to save it, otherwise just save it.
"command -nargs=0 -bar Update if &modified 
"                            \|    if empty(bufname('%'))
"                            \|        browse confirm write
"                            \|    else
"                            \|        confirm write
"                            \|    endif
"                            \|endif
"nnoremap <silent> <C-S> :<C-u>Update<CR>
"inoremap <c-s> <c-o>:Update<CR>
" Cannot get it to work with unnamed buffers
nnoremap <silent> <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>

" Buffers
nnoremap <Leader>B :buffers<CR>:buffer<Space>
nnoremap <Leader>b :bp<CR>
nnoremap <Leader>n :bn<CR>
nnoremap <Leader>g :e#<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" LeaderF
let g:Lf_ShortcutF = '<C-P>'

" jedi
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_definitions_command = ""
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_stubs_command = "<leader>s"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<leader>r"
"let g:jedi#completions_command = "<C-Space>"

" Tab completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#manual_complete()
"   \ deoplete#complete()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" fully manual
" use #manual_complete on Tab
call deoplete#custom#option('auto_complete', 0)
" autocompletion,manual popup
" use #complete() on Tab
" completion is async so it only display current result
" but does not lock
"call deoplete#custom#option({
"      \ 'auto_complete_popup': 'manual',
"      \ })
" Nonconditional completion
" Could be a it more sophisticated
inoremap <silent><expr> <C-Space> deoplete#manual_complete()
