set incsearch

"          tab indentation

set tabstop=2
set shiftwidth=2
set expandtab
set hidden


"          keybindings

"     vim with st have some troubles with [crtl/shift-key] understanding
"     so map it

noremap  <ESC>[1;5A <C-Up>
noremap  <ESC>[1;5B <C-Down>
inoremap <ESC>[1;5A <C-o>{
inoremap <ESC>[1;5B <C-o>}
noremap  <ESC>[1;5C <C-Right>
noremap  <ESC>[1;5D <C-Left>
noremap! <ESC>[1;5C <C-Right>
noremap! <ESC>[1;5D <C-Left>
noremap  <ESC>[1;2A <S-Up>
noremap  <ESC>[1;2B <S-Down>
noremap  <ESC>[1;2C <S-Right>
noremap  <ESC>[1;2D <S-Left>
