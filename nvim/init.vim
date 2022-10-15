" this will install vim-plug if not installed
set mouse=
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

let g:python3_host_prog = '/Users/ioanniskarasavvaidis/.pyenv/shims/python'
let g:python_host_prog='/usr/bin/python2'

set statusline+=%{coc#status()}

call plug#begin()
" here you'll add all the plugins needed
if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
  "Plug 'danth/pathfinder.vim'
  Plug 'vim-vdebug/vdebug'
  Plug 'neoclide/coc.nvim', {'do': 'npm install --frozen-lockfile', 'branch': 'release'} " this is for auto complete, prettier and tslinting
  Plug 'yaegassy/coc-graphql', {'do': 'yarn install --frozen-lockfile'}
  let g:coc_global_extensions = ['coc-graphql', 'coc-phpactor', 'coc-sql',  'coc-cmake', 'coc-browser', 'coc-svg', 'coc-tsserver','coc-eslint', 'coc-stylelint', 'coc-pyright', 'coc-markdownlint', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-git' ]  " list of CoC extensions needed

  Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } } " this is for the firevim plugin
  Plug 'wakatime/vim-wakatime' " this is for the wakatime plugin (for tracking time spent in vim)
  Plug 'nvim-lua/plenary.nvim' " this is for the plenary plugin (for lua)
  Plug 'github/copilot.vim' " this is for the copilot plugin (for copilot)
  Plug 'sindrets/diffview.nvim' " this is for the diffview ( git diff ) )
  " Plug 'kyazdani42/nvim-web-devicons'
  Plug 'Pocco81/auto-save.nvim'
  Plug 'wikitopian/hardmode'
  Plug 'mhartington/oceanic-next'
  Plug 'Mofiqul/vscode.nvim'
  " Plug 'jnurmine/zenburn' "Theme plugin
  Plug 'vim-airline/vim-airline' "Status bar
  Plug 'vim-airline/vim-airline-themes' "Applicable themes
  Plug 'ryanoasis/vim-devicons' "Icons for filetypes
  Plug 'ap/vim-css-color' "  color name highlighter

  " Language Syntax Support
  Plug 'pangloss/vim-javascript' "JS highlighting
  Plug 'mxw/vim-jsx' "JSX syntax highlighting
  Plug 'jparise/vim-graphql' "graphql syntax highlighting
  Plug 'digitaltoad/vim-pug' "Pug highlighting
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  " Plug 'mustache/vim-mustache-handlebars' "Handlebars highlighting

  " Puppet sytanx and highlight
  Plug 'mrk21/yaml-vim' " For hieradata
  Plug 'rodjek/vim-puppet' " For Puppet syntax highlighting
  Plug 'vim-ruby/vim-ruby' " For Facts, Ruby functions, and custom providers
  Plug 'elzr/vim-json' " For metadata.json


  " Mardown Syntax
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
  Plug 'vim-pandoc/vim-rmarkdown'

  " Tools
  " Plug 'mitermayer/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  Plug 'jiangmiao/auto-pairs' "Autocomplete brackets.
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-fugitive' "Git tools
  Plug 'metakirby5/codi.vim'
  Plug 'pocco81/auto-save.nvim'

  Plug 'mattn/emmet-vim' "A bit annoying because it takes over my Tab key
  Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} "Nerdtree
  " For PHP
  "Plug 'ncm2/ncm2', {'for': 'php'}
  "Plug 'roxma/nvim-yarp'
  "Plug 'phpactor/phpactor', { 'do': ':call phpactor#Update()', 'for': 'php'}
  "Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
  Plug 'ncm2/ncm2-ultisnips', {'for': 'php'}
  Plug 'StanAngeloff/php.vim', {'for': 'php'}
  Plug 'w0rp/ale', {'for': 'php'}

endif
call plug#end()


" For PHP stuff
"augroup ncm2
"  au!
"  autocmd BufEnter * call ncm2#enable_for_buffer()
"  au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
"  au User Ncm2PopupClose set completeopt=menuone
"augroup END

" Copilot nodejs
"let g:copilot_node_command = "~/opt/bin/nvm/versions/node/v16.13.0/bin/node"

" Debugger
let g:vdebug_options = {"port": 9003, "break_on_open": 0 }
let g:vdebug_options["path_maps"] = {
\    "/var/www/html": $PWD."/site",
\}

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1
" PHP stuff end


" deal with swps and backups here
" create backups
set backup
" tell vim where to put its backup files
set backupdir=~/.tmp
" tell vim where to put swap files
set dir=~/.tmp
set timeoutlen=1000        " speed vim up
set ttimeoutlen=0          " https://stackoverflow.com/questions/37644682/why-is-vim-so-slow/37645334
set ttyfast                " Rendering
set tw=500
" Disable Autocommenting
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" navigate through tabs
map <C-L> gt
map <C-H> gT

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Changes NerdTree Toggle to Ctrl + n
map <C-n> :NERDTreeToggle<CR>
" autocmd VimEnter * NERDTree "Toggles Nerdtree on vim open
let NERDTreeQuitOnOpen = 1 "closes NerdTree when opening a file
let g:airline_powerline_fonts = 1
" for the fonts
set encoding=UTF-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add shortcut for it
map <C-p> :GFiles --cached --others --exclude-standard<CR>
map <C-\> :Rg<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Conquer of Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" this is a comment so you remember this later
" insert mode; no recursive; map; <from>; <to>
inoremap jk <Esc>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2     " tab spacing
set expandtab     " tabs are now spaces
set ai            " Auto indent
" set si            " Smart indent
set wrap          " Wrap lines
set nowrap        " Don't wrap text

" Show line numbers
" turn absolute line numbers on
:set number
:set nu

" Code fold bliss
" https://www.linux.com/learn/vim-tips-folding-fun
" set foldmethod=indent

" Blink cursor on error instead of beeping (grr)
set visualbell
set t_vb=


" adds blue highlight to vim in visual mode selections
highlight Visual cterm=bold ctermbg=Blue ctermfg=NONE
" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
endif

" Shows the title within the window
set title titlestring=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Prettier
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autosave
" disables autosave feature
" let g:prettier#autoformat = 0

" print spaces between brackets
" Prettier default: true
"let g:prettier#config#bracket_spacing = 'true'

" runs prettier on file formats
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" configuration for vim-pandoc and vim-rmarkdown
let g:pandoc#modules#disabled = ["folding", "spell"]
let g:pandoc#syntax#conceal#use = 0

" Emmet
let g:user_emmet_leader_key=',' " Redefine emmet leader key. It's now ,,
" let g:user_emmet_expandabbr_key='<Tab>'

" Syntax stuff
" This lets vim know that .prisma files should be graphql.
" Stolen from vim-graphql/ftdetect/graphql.vim
au BufRead,BufNewFile *.prisma setfiletype graphql

set secure "disables unsafe commands in project specific .vimrc

" Hard mode disable some keys
let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = ' Dont use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

autocmd BufEnter *.hbs :set ft=html

if !exists('g:vscode')

  " Theme
  let g:vscode_style = "dark"
  colorscheme vscode

  " AutoSave configuration

  lua << EOF
    local autosave = require("auto-save")
    autosave.setup({
            enabled = false,
            execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
            events = {"InsertLeave", "TextChanged"},
            conditions = {
                exists = true,
                filename_is_not = {},
                filetype_is_not = {},
                modifiable = true,
            },
            write_all_buffers = false,
            on_off_commands = true,
            clean_command_line_interval = 0,
            debounce_delay = 135,
        })
EOF


endif
