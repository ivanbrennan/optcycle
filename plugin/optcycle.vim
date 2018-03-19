if exists("g:loaded_optcycle") || &cp
  finish
endif
let g:loaded_optcycle = 1

command! -nargs=? -bar  OColorscheme  call optcycle#colorscheme(<f-args>)
command! -nargs=? -bar  ONumber       call optcycle#number(<f-args>)
command! -nargs=? -bar  OFoldColumn   call optcycle#foldcolumn(<f-args>)
command! -nargs=? -bar  OFoldMethod   call optcycle#foldmethod(<f-args>)
command! -nargs=? -bar  OColorColumn  call optcycle#colorcolumn(<f-args>)
command! -nargs=? -bar  OLastStatus   call optcycle#laststatus(<f-args>)

nnoremap <silent> <Plug>(optcycle_colorscheme+)  :call optcycle#colorscheme(+1)<CR>
nnoremap <silent> <Plug>(optcycle_colorscheme-)  :call optcycle#colorscheme(-1)<CR>

nnoremap <silent> <Plug>(optcycle_number+)       :call optcycle#number(+1)<CR>
nnoremap <silent> <Plug>(optcycle_number-)       :call optcycle#number(-1)<CR>

nnoremap <silent> <Plug>(optcycle_foldcolumn+)   :call optcycle#foldcolumn(+1)<CR>
nnoremap <silent> <Plug>(optcycle_foldcolumn-)   :call optcycle#foldcolumn(-1)<CR>

nnoremap <silent> <Plug>(optcycle_foldmethod+)   :call optcycle#foldmethod(+1)<CR>
nnoremap <silent> <Plug>(optcycle_foldmethod-)   :call optcycle#foldmethod(-1)<CR>

nnoremap <silent> <Plug>(optcycle_colorcolumn+)  :call optcycle#colorcolumn(+1)<CR>
nnoremap <silent> <Plug>(optcycle_colorcolumn-)  :call optcycle#colorcolumn(-1)<CR>

nnoremap <silent> <Plug>(optcycle_laststatus+)   :call optcycle#laststatus(+1)<CR>
nnoremap <silent> <Plug>(optcycle_laststatus-)   :call optcycle#laststatus(-1)<CR>
