if exists("g:loaded_optcycle") || &cp
  finish
endif
let g:loaded_optcycle = 1

command! -nargs=0 -bar  OptcycleColorscheme  call optcycle#colorscheme()
command! -nargs=0 -bar  OptcycleNumber       call optcycle#number()
command! -nargs=0 -bar  OptcycleFoldColumn   call optcycle#foldcolumn()
command! -nargs=0 -bar  OptcycleFoldMethod   call optcycle#foldmethod()
command! -nargs=0 -bar  OptcycleColorColumn  call optcycle#colorcolumn()
command! -nargs=0 -bar  OptcycleLastStatus   call optcycle#laststatus()

nnoremap <silent> <Plug>(optcycle_colorscheme)  :OptcycleColorscheme<CR>
nnoremap <silent> <Plug>(optcycle_number)       :OptcycleNumber<CR>
nnoremap <silent> <Plug>(optcycle_foldcolumn)   :OptcycleFoldColumn<CR>
nnoremap <silent> <Plug>(optcycle_foldmethod)   :OptcycleFoldMethod<CR>
nnoremap <silent> <Plug>(optcycle_colorcolumn)  :OptcycleColorColumn<CR>
nnoremap <silent> <Plug>(optcycle_laststatus)   :OptcycleLastStatus<CR>
