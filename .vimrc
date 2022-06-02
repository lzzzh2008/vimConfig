
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

let skip_defaults_vim=1
let mapleader = "`"

call plug#begin('~/.vim/plugged')
Plug 'mhinz/vim-startify'
" Plug 'preservim/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'franbach/miramare'
Plug 'pangloss/vim-javascript'
Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline'
" Plug 'christoomey/vim-tmux-navigator'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-smooth-scroll'
Plug 'jiangmiao/auto-pairs'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
" Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'francoiscabrol/ranger.vim'
" Plug 'kevinhwang91/rnvimr'
Plug 'rbgrouleff/bclose.vim'
Plug 'preservim/nerdcommenter'
" Plug 'zivyangll/git-blame.vim'
Plug 'APZelos/blamer.nvim'
Plug 'morhetz/gruvbox'
Plug 'voldikss/vim-floaterm'
" code runner
Plug 'xianzhon/vim-code-runner'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'kristijanhusak/defx-git'

Plug 'github/copilot.vim'

call plug#end()

" theme setting
" set onedark
" set termguicolors

let g:airline_theme='miramare'
" let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1   
let g:miramare_enable_italic = 1
let g:miramare_disable_italic_comment = 1

syntax on
colorscheme gruvbox
" colorscheme miramare


" Configuration file for vim
set modelines=0		" CVE-2007-2438
filetype on
" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
set shiftwidth=2
set tabstop=2
set autoindent
set smarttab  
set expandtab
set number
set relativenumber " 相对行号
set autoindent
set autowriteall
set cindent
set autoread
set ignorecase " 查找忽略大小写
set smartcase  " 查找大写时不忽略
set expandtab " 将tab转换成空格
set clipboard+=unnamed " 共享剪贴板


" Visual
set showmatch "显示括号匹配
set matchtime=5 "括号显示时间
" set autochdir " 自动打开当前目录
set autowrite

" tnoremap kj <C-\><C-n>
" keymap
" 缩进
nnoremap < << 
nnoremap > >> 
" 切换到当前目录
nnoremap <silent> <leader>. :cd %:p:h<CR>

"将jk映射到Esc
"noremap jk <Esc>

" 替换 ^ $ G gg 
noremap H ^
noremap L $
noremap J G
noremap K gg

" copy & pasete

let g:neovide_input_use_logo = 1
cnoremap <D-v> "+p<CR>
map! <D-v> <C-R>+
tmap <D-v> <C-R>+
vmap <D-c> "+y<CR> 

" PluginSetting
"
" NERDTree
" map <leader>t :NERDTreeToggle<CR>
" close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" copy current file path
function GetCurFilePath()
    let cur_dir=getcwd()
    let cur_file_name=getreg('%')
    let dir_filename=cur_dir."".cur_file_name
    echo dir_filename."         done"
    call setreg('+',dir_filename)
endfunction
nnoremap <silent> <Leader>p :call GetCurFilePath()<CR>
" FzF
" 打开 fzf 的方式选择 floating window
let g:fzf_layout = { 'down': '~70%', 'window': 'call OpenFloatingWin()' }

function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  " 设置浮动窗口打开的位置，大小等。
  " 这里的大小配置可能不是那么的 flexible 有继续改进的空间
        " \ 'width': width * 3/4,
        " \ 'height': height/2
        " \ 'row': height * 0.3,
        " \ 'col': col + 30,
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  " 设置浮动窗口高亮
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

" 让输入上方，搜索列表在下方
let $FZF_DEFAULT_OPTS = '--layout=reverse'
let $FZF_DEFAULT_COMMAND= "fd --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build} --type f -H"

" fzf vim
nnoremap  <silent> <Leader>ag :Ag<CR>
nnoremap  <silent> <Leader>b :Buffers<CR>
nnoremap  <C-p> :Files<CR>

" smooth scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 6, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 6, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 6, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 6, 4)<CR>

" easymotion
" 使用 ss 启用
nmap ss <Plug>(easymotion-s2)


" vim-go 配置
autocmd FileType go nmap <leader>r <Plug>(go-run)

let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:vim_json_syntax_conceal = 0 "" 为了防止导致json的引号自动隐藏
let g:indentLine_noConcealCursor=""  " 为了防止导致json的引号自动隐藏
" coc 配置
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
autocmd CursorHold * silent call CocActionAsync('highlight')
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>z  <Plug>(coc-format-selected)
nmap <leader>z <Plug>(coc-format-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <C-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" GoTo code navigation.
nmap <silent> <C-]> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif


" ===
" === airline
" ===
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'

" ===
" === git-blame
" ===
" nnoremap <Leader>s :<C-u>call gitblame#echo()<CR>

" ===
" === vimbuffer
" ===

noremap <leader>] :bn<CR>
noremap <leader>[ :bp<CR>
noremap <leader>x :bd<CR>

" ===
" === ranger 
" ===
" let g:NERDTreeHijackNetrw = 0 " add this line if you use NERDTree
" let g:ranger_replace_netrw = 1 " open ranger when vim open a directory

" ===
" === NerdCommenter 
" ===
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" neovide 

let g:neovide_refresh_rate=144

let g:neovide_transparency=0.95

let g:neovide_cursor_vfx_mode = "pixiedust"

" let g:neovide_cursor_trail_length=0.3

" let g:neovide_cursor_animation_length=0.08

set guifont=FiraCode\ Nerd\ Font,宋体\-简:h19

set encoding=utf-8

" terminal
let g:floaterm_keymap_toggle = '<Leader>t'

" vim-git-blamer
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0

" vim code runner
nmap <silent><leader>j <plug>CodeRunner
let g:code_runner_save_before_execute= 1 
let g:CodeRunnerCommandMap = {
      \ 'typescript' : '   node $fileName'
      \}
" copilot
let g:copilot_node_command = "/Users/zzh/.nvm/versions/node/v16.13.0/bin/node"
" Defx

" Define mappings
"cnoreabbrev sf Defx -listed -new
"      \ -columns=indent:mark:icon:icons:filename:git:size
"      \ -buffer-name=tab`tabpagenr()`<CR>
nnoremap <silent><leader>w :<C-u>Defx -toggle -listed -resume 
      \ -columns=-columns=indent:git:icon:icons:filename:type
      \ -buffer-name=tab`tabpagenr()`
      \ `expand('%:p:h')` -search=`expand('%:p')`<CR>
nnoremap <silent>s :<C-u>Defx -new `expand('%:p:h')` -search=`expand('%:p')`<CR>

autocmd FileType defx call s:defx_my_settings()
	function! s:defx_my_settings() abort
	  " Define mappings
	  nnoremap <silent><buffer><expr> <CR>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('copy')
	  nnoremap <silent><buffer><expr> dd
	  \ defx#do_action('move')
	  nnoremap <silent><buffer><expr> pp
	  \ defx#do_action('paste')
	  nnoremap <silent><buffer><expr> l
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> <Right>
	  \ defx#do_action('drop')
	  nnoremap <silent><buffer><expr> E
	  \ defx#do_action('open', 'vsplit')
	  nnoremap <silent><buffer><expr> n
	  \ defx#do_action('open', 'pedit')
	  nnoremap <silent><buffer><expr> i
	  \ defx#do_action('open', 'choose')
	  nnoremap <silent><buffer><expr> o
	  \ defx#do_action('open_or_close_tree')
	  nnoremap <silent><buffer><expr> K
	  \ defx#do_action('new_directory')
	  nnoremap <silent><buffer><expr> N
	  \ defx#do_action('new_file')
	  nnoremap <silent><buffer><expr> M
	  \ defx#do_action('new_multiple_files')
	  nnoremap <silent><buffer><expr> C
	  \ defx#do_action('toggle_columns',
	  \                'mark:indent:icon:filename:type:size:time')
	  nnoremap <silent><buffer><expr> S
	  \ defx#do_action('toggle_sort', 'time')
	  nnoremap <silent><buffer><expr> dD
	  \ defx#do_action('remove')
	  nnoremap <silent><buffer><expr> r
	  \ defx#do_action('rename')
	  nnoremap <silent><buffer><expr> !
	  \ defx#do_action('execute_command')
	  nnoremap <silent><buffer><expr> x
	  \ defx#do_action('execute_system')
	  nnoremap <silent><buffer><expr> YY
	  \ defx#do_action('yank_path')
	  nnoremap <silent><buffer><expr> .
	  \ defx#do_action('toggle_ignored_files')
	  nnoremap <silent><buffer><expr> ;
	  \ defx#do_action('repeat')
	  nnoremap <silent><buffer><expr> h
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> <Left>
	  \ defx#do_action('cd', ['..'])
	  nnoremap <silent><buffer><expr> ~
	  \ defx#do_action('cd')
	  nnoremap <silent><buffer><expr> q
	  \ defx#do_action('quit')
	  nnoremap <silent><buffer><expr> <Space>
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> m
	  \ defx#do_action('toggle_select') . 'j'
	  nnoremap <silent><buffer><expr> vv
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> *
	  \ defx#do_action('toggle_select_all')
	  nnoremap <silent><buffer><expr> j
	  \ line('.') == line('$') ? 'gg' : 'j'
	  nnoremap <silent><buffer><expr> k
	  \ line('.') == 1 ? 'G' : 'k'
	  nnoremap <silent><buffer><expr> <C-l>
	  \ defx#do_action('redraw')
	  nnoremap <silent><buffer><expr> <C-g>
	  \ defx#do_action('print')
	  nnoremap <silent><buffer><expr> cd
	  \ defx#do_action('change_vim_cwd')
		nnoremap <silent><buffer><expr> > defx#do_action('resize',
		\ defx#get_context().winwidth + 10)
		nnoremap <silent><buffer><expr> < defx#do_action('resize',
		\ defx#get_context().winwidth - 10)
	endfunction

call defx#custom#column('icon', {
      \ 'directory_icon': '▸',
      \ 'opened_icon': '▾',
      \ 'root_icon': ' ',
      \ })

call defx#custom#column('git', 'indicators', {
  \ 'Modified'  : 'M',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ })

call defx#custom#option('_', {
            \ 'winwidth': 30,
            \ 'split': 'vertical',
            \ 'direction': 'topleft',
            \ 'show_ignored_files': 0,
            \ 'buffer_name': '',
            \ })


autocmd BufWritePost * call defx#redraw()
" autocmd WinClosed * if winnr('$') <= 2 | qall | endif


