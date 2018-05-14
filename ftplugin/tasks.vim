" Tasks plugin
" Language:    Tasks
" Maintainer:  veirus
" Last Change: 2018-05-10
" Version:     0.2
" URL:         https://github.com/veirus/vim-tasks
" Fork from:   https://github.com/jmolero/vim-tasks

if exists("b:loaded_tasks")
	finish
endif
let b:loaded_tasks = 1

setlocal foldmethod=indent

" MAPPINGS
nnoremap <buffer> <leader>n :call tasks#NewTask(1)<cr>
nnoremap <buffer> <leader>N :call tasks#NewTask(-1)<cr>
nnoremap <buffer> <leader>d :call tasks#TaskComplete()<cr>
nnoremap <buffer> <leader>x :call tasks#TaskCancel()<cr>
nnoremap <buffer> <leader>a :call tasks#TasksArchive()<cr>

" Separator func from:
" https://github.com/elentok/plaintasks.vim/blob/master/ftplugin/plaintasks.vim
abbr -- <c-r>=tasks#Separator()<cr>

" GLOBALS
" Helper for initializing defaults
" (https://github.com/scrooloose/nerdtree/blob/master/plugin/NERD_tree.vim#L39)
function! s:initVariable(var, value)
	if !exists(a:var)
		exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
		return 1
	endif
	return 0
endfunc

call s:initVariable('g:TasksMarkerIsPlaintext', '0')
if g:TasksMarkerIsPlaintext
	call s:initVariable('g:TasksMarkerBase', '[ ]')
	call s:initVariable('g:TasksMarkerDone', '[X]')
	call s:initVariable('g:TasksMarkerCancelled', '[-]')
else
	call s:initVariable('g:TasksMarkerBase', '☐')
	call s:initVariable('g:TasksMarkerDone', '✔')
	call s:initVariable('g:TasksMarkerCancelled', '✘')
endif
call s:initVariable('g:TasksDateFormat', '%Y-%m-%d %H:%M')
call s:initVariable('g:TasksAttributeMarker', '@')
call s:initVariable('g:TasksArchiveSeparator', '＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿＿')

let b:regesc = '[]()?.*@='


