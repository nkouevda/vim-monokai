set background=dark

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monokai'

if !exists('g:monokai_256_cterm')
  let g:monokai_256_cterm = 1
endif

if !exists('g:monokai_256_gui')
  let g:monokai_256_gui = 0
endif

let s:colors = {}
let s:colors.0   = [  '0', '235', '#272822', '#262626']
let s:colors.1   = [  '1', '197', '#f92672', '#ff005f']
let s:colors.2   = [  '2', '118', '#a6e22e', '#87ff00']
let s:colors.3   = [  '3', '185', '#e6db74', '#d7d75f']
let s:colors.4   = [  '4', '135', '#ae81ff', '#af5fff']
let s:colors.5   = [  '5', '208', '#fd971f', '#ff8700']
let s:colors.6   = [  '6',  '81', '#66d9ef', '#5fd7ff']
let s:colors.7   = [  '7', '255', '#f8f8f2', '#eeeeee']
let s:colors.8   = [  '8', '238', '#5d5e59', '#444444']
let s:colors.237 = ['237', '237', '#3e3d32', '#3a3a3a']
let s:colors.238 = ['238', '238', '#49483e', '#444444']
let s:colors.243 = ['243', '243', '#75715e', '#767676']

" See `:help g:terminal_ansi_colors`
let s:ansi = filter(copy(s:colors), { k -> k < 8 })
let s:ansi_hex = map(copy(s:ansi), { k, v -> v[2 + g:monokai_256_gui] })
let g:terminal_ansi_colors = repeat(values(s:ansi_hex), 2)

function! s:highlight(group, fg_key, bg_key, ...)
  let l:attrs = a:0 ? a:1 : 'NONE'
  exe 'hi ' . a:group . ' cterm=' . l:attrs . ' gui=' . l:attrs

  let l:fgs = get(s:colors, a:fg_key, ['NONE', 'NONE', 'NONE', 'NONE'])
  exe 'hi ' . a:group . ' ctermfg=' . l:fgs[g:monokai_256_cterm]
  exe 'hi ' . a:group . ' guifg=' . l:fgs[2 + g:monokai_256_gui]

  let l:bgs = get(s:colors, a:bg_key, ['NONE', 'NONE', 'NONE', 'NONE'])
  exe 'hi ' . a:group . ' ctermbg=' . l:bgs[g:monokai_256_cterm]
  exe 'hi ' . a:group . ' guibg=' . l:bgs[2 + g:monokai_256_gui]
endfunction

" General
call s:highlight('Normal', '7', '0')
call s:highlight('Visual', '', '8')
hi! link VisualNOS Visual
call s:highlight('Search', '0', '3')
call s:highlight('IncSearch', '0', '5')
call s:highlight('Folded', '243', '238')
hi! link FoldColumn Folded
call s:highlight('NonText', '243', '')
hi! link LineNr NonText
hi! link SignColumn NonText
call s:highlight('Cursor', '0', '7')
call s:highlight('CursorLine', '', '237')
hi! link CursorLineNr CursorLine
hi! link CursorColumn CursorLine

" Splits, status lines, and tab line
call s:highlight('VertSplit', '237', '237')
call s:highlight('StatusLine', '7', '237')
call s:highlight('StatusLineNC', '243', '237')
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link TabLine StatusLineNC
hi! link TabNum TabLine
hi! link TabWinNum TabLine
hi! link TabLineSel StatusLine
hi! link TabNumSel TabLineSel
hi! link TabWinNumSel TabLineSel
hi! link TabLineFill VertSplit

" Popup menu and command line completion menu
hi! link Pmenu StatusLine
call s:highlight('PmenuSbar', '', '238')
call s:highlight('PmenuThumb', '', '243')
call s:highlight('PmenuSel', '0', '6')
hi! link WildMenu PmenuSel

" Syntax
hi! link Comment NonText
call s:highlight('Constant', '4', '')
call s:highlight('String', '3', '')
hi! link Character String
call s:highlight('Identifier', '5', '')
call s:highlight('Function', '2', '')
call s:highlight('Statement', '1', '')
hi! link PreProc Statement
call s:highlight('Type', '6', '')
hi! link StorageClass Statement
hi! link Special String
hi! link SpecialChar Constant
hi! link Delimiter Constant
call s:highlight('Underlined', '6', '', 'underline')
hi! link Ignore Comment
call s:highlight('Error', '0', '1')
hi! link Todo IncSearch

" Spelling
hi! link SpellBad Error
call s:highlight('SpellCap', '0', '4')
hi! link SpellLocal SpellCap
hi! link SpellRare SpellCap

" Messages
hi! link ModeMsg Normal
hi! link Title Identifier
hi! link MoreMsg Title
hi! link WarningMsg MoreMsg
hi! link Question MoreMsg
hi! link ErrorMsg Statement

" Diff
hi! link DiffAdd Search
call s:highlight('DiffDelete', '0', '0')
hi! link DiffChange Visual
hi! link DiffText DiffAdd

" Miscellaneous
hi! link ColorColumn Error
hi! link Conceal NonText
hi! link Directory Constant
call s:highlight('MatchParen', '0', '243')
hi! link QuickFixLine Visual
hi! link SpecialKey NonText

" Clean up
unlet s:colors s:ansi s:ansi_hex
delfunction s:highlight
