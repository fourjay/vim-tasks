" Tasks plugin
" Language:    Tasks
" Maintainer:  veirus
" Last Change: 2018-05-10
" Version:     0.2
" URL:         https://github.com/veirus/vim-tasks
" Fork from:   https://github.com/jmolero/vim-tasks

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'tasks'
endif

silent! syntax include @markdown syntax/markdown.vim
unlet! b:current_syntax

syn case match
syn sync fromstart

let b:regesc = '[]()?.*@='

function! s:CreateMatch(name, regex)
  exec 'syn match ' . a:name . ' "' . a:regex . '" contained'
endfunc


call s:CreateMatch('tMarker', '^\s*' . escape(g:TasksMarkerBase, b:regesc))
call s:CreateMatch('tMarkerCancelled', '^\s*' . escape(g:TasksMarkerCancelled, b:regesc))
call s:CreateMatch('tMarkerComplete', '^\s*' . escape(g:TasksMarkerDone, b:regesc))

exec 'syn match tAttribute "' . g:TasksAttributeMarker . '\w\+\(([^)]*)\)\=" contained'
exec 'syn match tAttributeCompleted "' . g:TasksAttributeMarker . '\w\+\(([^)]*)\)\=" contained'

syn region tTask start=/^\s*/ end=/$/ oneline keepend contains=tMarker,tAttribute
exec 'syn match tTaskNote "^\(\(.*' . g:TasksMarkerBase . '.*\)\@!.\)*$"'
exec 'syn region tTaskDone start="^[\s]*.*'.g:TasksAttributeMarker.'done" end=/$/ oneline contains=tMarkerComplete,tAttributeCompleted'
exec 'syn region tTaskCancelled start="^[\s]*.*'.g:TasksAttributeMarker.'cancelled" end=/$/ oneline contains=tMarkerCancelled,tAttributeCompleted'
syn match tProject "^\s*.*:$"

hi def link tTaskNote Comment
hi def link tMarker Normal
hi def link tMarkerComplete Function
hi def link tMarkerCancelled Statement
hi def link tAttribute CursorLineNr
hi def link tAttributeCompleted Function
hi def link tTaskDone Comment
hi def link tTaskCancelled Comment
hi def link tProject Constant
