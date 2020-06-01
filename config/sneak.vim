
" case insensitive sneak
let g:sneak#use_ic_scs = 1

" remap the jumps so I can use , and ; with f and t
map gS <Plug>Sneak_,
map gs <Plug>Sneak_;

" immediately move to the next instance of search, if you move the cursor sneak is back to default behavior
let g:sneak#s_next = 1

" Cool prompt
let g:sneak#prompt = '🔎 '

