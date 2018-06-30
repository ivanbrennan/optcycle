if exists("g:autoloaded_optcycle") || &cp
  finish
endif
let g:autoloaded_optcycle = 1

" Override any of the defaults by defining g:optcycle_config
"  let g:optcycle_config =
"  \ {
"  \   'colorscheme': [
"  \     { 'colorscheme': 'nord' },
"  \     { 'colorscheme': 'monokai' }
"  \   ]
"  \ }
let s:defaults =
\ {
\   'colorscheme': [
\     { 'colorscheme': 'default' }
\   ],
\   'number': [
\     { 'number': 1, 'foldcolumn': 0 },
\     { 'number': 0, 'foldcolumn': 1 }
\   ],
\   'foldcolumn': [
\     { 'foldcolumn': 0, 'number': 1, 'relativenumber': 0 },
\     { 'foldcolumn': 4, 'number': 0, 'relativenumber': 0 }
\   ],
\   'foldmethod': [
\     { 'foldmethod': 'syntax', 'g:ruby_fold': 1 },
\     { 'foldmethod': 'indent' },
\     { 'foldmethod': 'marker' }
\   ],
\   'colorcolumn': [
\     { 'colorcolumn':       '', 'long_line':       '' },
\     { 'colorcolumn': 'tw 100', 'long_line':       '' },
\     { 'colorcolumn':       '', 'long_line': 'tw 100' }
\   ],
\   'laststatus': [
\     { 'laststatus': 2 },
\     { 'laststatus': 0 }
\   ],
\   'spell': [
\     { 'spell': 0, 'cursorline': 1 },
\     { 'spell': 1, 'cursorline': 0 }
\   ]
\ }

func! s:choices(opt) abort
  let conf = get(g:, 'optcycle_config', {})
  return get(conf, a:opt, s:defaults[a:opt])
endf

func! s:indices(scope) abort
  let indices = get(a:scope, 'optcycle_indices', {})
  let a:scope['optcycle_indices'] = indices
  return indices
endf

func! s:rotate_choices(scope, opt, n) abort
  let choices = s:choices(a:opt)
  let indices = s:indices(a:scope)
  let o = get(indices, a:opt, 0)
  let i = (o + a:n) % len(choices)
  let indices[a:opt] = i

  return choices[i]
endf

func! s:rotate(scope, opt, n) abort
  let choice = s:rotate_choices(a:scope, a:opt, a:n)
  for [option, value] in items(choice)
    exec 'let &l:'.option '=' value
  endfor
  exec 'set' a:opt.'?'
endf

func! s:clicks(args) abort
  return get(a:args, 1, 1) " get value of first arg, default to 1
endf

" -- autoload functions

func! optcycle#colorscheme(...) abort
  let choice = s:rotate_choices(s:, 'colorscheme', s:clicks(a:))
  exec 'colorscheme' choice['colorscheme']
  redrawstatus | colorscheme
endf

func! optcycle#number(...) abort
  call s:rotate(w:, 'number', s:clicks(a:))
endf

func! optcycle#foldcolumn(...) abort
  call s:rotate(w:, 'foldcolumn', s:clicks(a:))
endf

func! optcycle#foldmethod(...) abort
  let choice = s:rotate_choices(w:, 'foldmethod', s:clicks(a:))
  let &l:foldmethod = choice['foldmethod']
  call s:update_ruby_fold(choice)
  set foldmethod?
endf

func! s:update_ruby_fold(choice) abort
  if &filetype == 'ruby'
    if has_key(a:choice, 'g:ruby_fold')
      let g:ruby_fold = a:choice['g:ruby_fold']
    elseif exists('g:ruby_fold')
      unlet g:ruby_fold
    endif
  endif
endf

func! optcycle#colorcolumn(...) abort
  if exists('w:long_line_highlight')
    call matchdelete(w:long_line_highlight)
    unlet w:long_line_highlight
  endif

  let choice = s:rotate_choices(w:, 'colorcolumn', s:clicks(a:))
  let &colorcolumn = s:colorcolumn_spec(choice['colorcolumn'])
  let long_line_spec = s:long_line_spec(choice['long_line'])
  if long_line_spec != ''
    let w:long_line_highlight = s:highlight_long_lines(long_line_spec)
  endif
endf

func! s:colorcolumn_spec(expr) abort
  let col = s:start_column(a:expr)
  return (col > 0) ? join(range(col+1, col+256),',') : ''
endf

func! s:long_line_spec(expr) abort
  let col = s:start_column(a:expr)
  return (col > 0) ? '\%>'.col.'v.' : ''
endf

func! s:start_column(expr) abort
  if &textwidth > 0 && match(a:expr, '\v<%(tw|textwidth)>') != -1
    return &textwidth
  else
    return str2nr(matchstr(a:expr, '\v[[:digit:]]+'))
  endif
endf

func! s:highlight_long_lines(spec) abort
  return matchadd('ColorColumn', a:spec, 128)
endf

func! optcycle#laststatus(...) abort
  call s:rotate(s:, 'laststatus', s:clicks(a:))
endf

func! optcycle#spell(...) abort
  call s:rotate(s:, 'spell', s:clicks(a:))
endf
