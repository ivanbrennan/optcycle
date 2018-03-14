if exists("g:loaded_optcycle") || &cp
  finish
endif
let g:loaded_optcycle = 1

nnoremap <silent> <Plug>(optcycle_colorscheme)  :call optcycle#colorscheme()<CR>
nnoremap <silent> <Plug>(optcycle_number)       :call optcycle#number()<CR>
nnoremap <silent> <Plug>(optcycle_foldcolumn)   :call optcycle#foldcolumn()<CR>
nnoremap <silent> <Plug>(optcycle_foldmethod)   :call optcycle#foldmethod()<CR>
nnoremap <silent> <Plug>(optcycle_colorcolumn)  :call optcycle#colorcolumn()<CR>
nnoremap <silent> <Plug>(optcycle_laststatus)   :call optcycle#laststatus()<CR>
