
let g:fzf_tags_command = 'ctags -R'
" Makes it a floating popup
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset': 0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" Have the colors match the theme colors
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Ripgrep command that will search file contents as opposed to filenames for
" content
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Helper fuzzy finder function that will get the git root folder, or the
" mercurial root folder based upon your current working directory. Otherwise
" it'll return the current directory
function! GetFuzzyDirectory()
  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]

  if v:shell_error
    let root = split(system('hg root'), '\n')[0]
    if v:shell_error
      let root = '.'
    endif
  endif

  return root
endfunction

" Custom command for Mercurial Repositories that mimics :GFiles but as :MFiles
command! -bang MFiles call fzf#run(fzf#wrap({ 'source': 'hg files' }))

" Key binding Ctrl-P to find files. They'll be from the repository
" directory if you're in a repository folder, otherwise it'll be the current
" working directory
nnoremap <silent> <C-p> :call fzf#vim#files(GetFuzzyDirectory(), {'options': '--prompt ""'})<CR>

" Key binding to search files with ripgrep similar to what I'd use in VSCode
nnoremap <silent> <C-S-f> :call RipgrepFzf('', 0)<CR>

