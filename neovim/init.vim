" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
let mapleader = "\<Space>"
call plug#begin()

Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
Plug 'airblade/vim-gitgutter'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'folke/trouble.nvim'
Plug 'tpope/vim-fugitive'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'hrsh7th/nvim-compe'
"Plug 'nvim-lua/completion-nvim'
"Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'
Plug 'cohama/lexima.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'ryanoasis/vim-devicons'
Plug 'preservim/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
" tabular plugin is used to format tables
Plug 'godlygeek/tabular'
" JSON front matter highlight plugin
Plug 'elzr/vim-json'
Plug 'plasticboy/vim-markdown'

Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'dhruvasagar/vim-zoom'
Plug 'Yggdroot/indentLine'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'


call plug#end()

"let g:nerdtree_tabs_open_on_gui_startup=0
"let g:nerdtree_tabs_open_on_new_tab=0

inoremap jj <ESC>

colorscheme gruvbox
let g:gruvbox_italic=1

set clipboard=unnamedplus

nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

" open NERDTree automatically
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * NERDTree

let g:NERDTreeGitStatusWithFlags = 1
"let g:WebDevIconsUnicodeDecorateFolderNodes = 1
"let g:NERDTreeGitStatusNodeColorization = 1
"let g:NERDTreeColorMapCustom = {
    "\ "Staged"    : "#0ee375",  
    "\ "Modified"  : "#d9bf91",  
    "\ "Renamed"   : "#51C9FC",  
    "\ "Untracked" : "#FCE77C",  
    "\ "Unmerged"  : "#FC51E6",  
    "\ "Dirty"     : "#FFBD61",  
    "\ "Clean"     : "#87939A",   
    "\ "Ignored"   : "#808080"   
    "\ }                         


let g:NERDTreeIgnore = ['^node_modules$']

" Autocomplete
set completeopt=menuone,noselect

" vim-prettier
"let g:prettier#quickfix_enabled = 0
"let g:prettier#quickfix_auto_focus = 0
" prettier command for coc
" run prettier on save
"let g:prettier#autoformat = 0

"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync

" markdown
" disable header folding

" do not use conceal feature, the implementation is not so good

" disable math tex conceal feature
"let g:vim_markdown_math = 0
"let g:vim_json_syntax_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0

"" Disable folding.
"let g:vim_markdown_folding_disabled = 1
"" Disable concealing.
"let g:vim_markdown_conceal = 0
"let g:tex_conceal = ""
"" Fix indentation.
"let g:vim_markdown_new_list_item_indent = 0
"" Follow anchors.
"let g:vim_markdown_follow_anchor = 1
"" Do not automatically insert bullet points.
"let g:vim_markdown_auto_insert_bullets = 0

" IndentLine
"let g:indentLine_setColors = 0
" Vim
"let g:indentLine_color_term = 239


" Background (Vim, GVim)
"let g:indentLine_bgcolor_term = 202
"let g:indentLine_bgcolor_gui = '#FF5F00'

" support front matter of various format
let g:vim_markdown_frontmatter = 0  " for YAML format
let g:vim_markdown_toml_frontmatter = 0  " for TOML format
let g:vim_markdown_json_frontmatter = 0  " for JSON format


" ctrlp
" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|build\|build-output\'

" j/k will move virtual lines (lines that wrap)
"noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
"noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

set relativenumber

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab

" sync open file with NERDTree
" " Check if NERDTree is open or active
function! IsNERDTreeOpen()        
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()


" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)

" lsconfig

lua << EOF
require('telescope').setup{ defaults = { file_ignore_patterns = {"node_modules", "build", "build_output"} } }

-- vim.cmd([[ autocmd ColorScheme * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights() ]]) 


local nvim_lsp = require('lspconfig')
local protocol = require'vim.lsp.protocol'

vim.lsp.set_log_level("debug")

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('i', '<S-C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'gp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', 'gn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

  -- formatting
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end

  -- require'completion'.on_attach(client, bufnr)

  --protocol.SymbolKind = { }
 -- protocol.CompletionItemKind = {
 --   'Óòí', -- Text
 --   'Ôûî', -- Method
 --   'Ôûî', -- Function
 --   'Ôûî', -- Constructor
 --   'Óûõ', -- Field
 --   'Óûõ', -- Variable
 --   'ÔÉ®', -- Class
 --   'Ô∞Æ', -- Interface
 --   'Ô£ñ', -- Module
 --   'Óò§', -- Property
 --   'Ôëµ', -- Unit
 --   'Ô¢ü', -- Value
 --   'ÔÉä', -- Enum
 --   'Ô†ä', -- Keyword
 --   'Ô¨å', -- Snippet
 --   'Óà´', -- Color
 --   'ÔÖõ', -- File
 --   'Ôöê', -- Reference
 --   'ÔÑï', -- Folder
 --   'ÔÖù', -- EnumMember
 --   'Óà¨', -- Constant
 --   'ÔÉä', -- Struct
 --   'ÔÉß', -- Event
 --   'Ô¨¶', -- Operator
 --   'Óòé', -- TypeParameter
 -- }
end

nvim_lsp.flow.setup {
  on_attach = on_attach
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = {
      spacing = 4,
      prefix = 'ÔÜ≤'
    }
  }
)


-- treesitter config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "tsx",
    "toml",
    "fish",
    "php",
    "json",
    "yaml",
    "swift",
    "html",
    "scss"
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.used_by = { "javascript", "typescript.tsx" }





-- lspsaga
local saga = require 'lspsaga'
saga.init_lsp_saga {
  error_sign = 'ÓÇ∞',
  warn_sign = 'ÓÇ∞',
  hint_sign = 'ÓÇ∞',
  infor_sign = 'ÓÇ∞',
  border_style = "round",
}



local actions = require('telescope.actions')
-- Global remapping
------------------------------
require('telescope').setup{
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close
      },
    },
  }
}



-- Lualine 
local status, lualine = pcall(require, "lualine")
if (not status) then return end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    section_separators = {'ÓÇ∞', 'ÓÇ≤'},
    component_separators = {'ÓÇ±', 'ÓÇ≥'},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = 'ÔÜà ', warn = 'ÔÅ± ', info = 'Ôëâ ', hint = 'ÔÉ´ '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'fugitive'}
}


-- Autocomplete nvim-compe

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, 
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}




EOF

" Nvim-compe
" NOTE: Order is important. You can't lazy loading lexima.vim.
let g:lexima_no_default_rules = v:true
call lexima#set_default_rules()
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm(lexima#expand('<LT>CR>', 'i'))
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })




" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



" Lsp saga
nnoremap <silent> <C-j> <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent>K <Cmd>Lspsaga hover_doc<CR>
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>


" Completion
"set completeopt=menuone,noinsert,noselect
"" Use <Tab> and <S-Tab> to navigate through popup menu
"inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"




" Description: My custom tabline settings

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T'

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    if i + 1 == tabpagenr()
      let s .= '%#TabLineSep#ÓÇ∞'
    elseif i + 2 == tabpagenr()
      let s .= '%#TabLineSep2#ÓÇ∞'
    else
      let s .= 'ÓÇ±'
    endif
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999X'
  endif

  return s
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let name = bufname(buflist[winnr - 1])
  let label = fnamemodify(name, ':t')
  return len(label) == 0 ? '[No Name]' : label
endfunction

set tabline=%!MyTabLine()



" save all files on focus lost and update on disk changes
augroup auto_save
  autocmd!
  " Frequently save automatically
  autocmd BufLeave,FocusLost * silent! wa
  " Check for file changes
  autocmd BufEnter,BufWinEnter,CursorHold,FocusGained * silent! checktime
augroup END

" -----------------------------------------------------------------------------
" Basic mappings
" -----------------------------------------------------------------------------

" Seamlessly treat visual lines as actual lines when moving around.
"noremap j gj
"noremap k gk
"noremap <Down> gj
"noremap <Up> gk
"inoremap <Down> <C-o>gj
"inoremap <Up> <C-o>gk

" Navigate around splits with a single key combo  
" Commenting as of now to support tmux navigation
"nnoremap <C-l> <C-w><C-l>
"nnoremap <C-h> <C-w><C-h>
"nnoremap <C-k> <C-w><C-k>
"nnoremap <C-j> <C-w><C-j>
""nnoremap <C-x> <C-w><C-x>
"nnoremap <C-m> <C-w><C-m>


" Cycle through splits.
nnoremap <S-Tab> <C-w>w

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Clear search highlights.
map <Leader><Space> :let @/=''<CR>

" Format paragraph (selected or not) to 80 character lines.
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" Edit Vim config file in a new tab.
map <Leader>ev :tabnew $MYVIMRC<CR>

" Source Vim config file.
map <Leader>sv :source $MYVIMRC<CR>

" Toggle spell check.
map <F5> :setlocal spell!<CR>

" Toggle relative line numbers and regular line numbers.
nmap <F6> :set invrelativenumber<CR>

" Automatically fix the last misspelled word and jump back to where you were.
"   Taken from this talk: https://www.youtube.com/watch?v=lwD8G1P52Sk
nnoremap <leader>sp :normal! mz[s1z=`z<CR>

" Toggle visually showing all whitespace characters.
noremap <F7> :set list!<CR>
inoremap <F7> <C-o>:set list!<CR>
cnoremap <F7> <C-c>:set list!<CR>

" Move 1 more lines up or down in normal and visual selection modes.
"nnoremap K :m .-2<CR>==
"nnoremap J :m .+1<CR>==
"vnoremap K :m '<-2<CR>gv=gv
"vnoremap J :m '>+1<CR>gv=gv
 


" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

set nocompatible
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set background=dark
set nobackup
set hlsearch
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
"set shell=fish
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
set tabstop=2
set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
 set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

"}}}

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
" highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40

" highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000

augroup BgHighlight
  autocmd!
  autocmd WinEnter * set cul
  autocmd WinLeave * set nocul
augroup END

if &term =~ "screen"
  autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
  autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
endif

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
" Flow
au BufNewFile,BufRead *.flow set filetype=javascript

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType coffee setlocal shiftwidth=2 tabstop=2
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
if has("unix")
  let s:uname = system("uname -s")
  " Do Mac stuff
  if s:uname == "Darwin\n"
    runtime ./macos.vim
  endif
endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  set background=dark
  " Use NeoSolarized
  " let g:neosolarized_termtrans=1
  " runtime ./colors/NeoSolarized.vim
  colorscheme gruvbox
endif

"}}}

" Extras "{{{
" ---------------------------------------------------------------------
set exrc
"}}}

" vim: set foldmethod=marker foldlevel=0:
# Configuration for Alacritty, the GPU enhanced terminal emulator


# Any items in the `env` entry below will be added as
# environment variables. Some entries may override variables
# set by alacritty it self.
env:
  # TERM env customization.
  #
  # If this property is not set, alacritty will set it to xterm-256color.
  #
  # Note that some xterm terminfo databases don't declare support for italics.
  # You can verify this by checking for the presence of `smso` and `sitm` in
  # `infocmp xterm-256color`.
  TERM: xterm-256color

window:
  # Window dimensions in character columns and lines
  # Falls back to size specified by window manager if set to 0x0.
  # (changes require restart)
  dimensions:
    columns: 0
    lines: 0

  dynamic_title: true

  # Adds this many blank pixels of padding around the window
  # Units are physical pixels; this is not DPI aware.
  # (change requires restart)
  padding:
    x: 2
    y: 2

  # Window decorations
  # Setting this to false will result in window without borders and title bar.
  decorations: full

  dynamic_title: true


scrolling:
  # How many lines of scrollback to keep,
  # '0' will disable scrolling.
  history: 10000

  # Number of lines the viewport will move for every line
  # scrolled when scrollback is enabled (history > 0).
  multiplier: 3

  # Faux Scrolling
  #
  # The `faux_multiplier` setting controls the number
  # of lines the terminal should scroll when the alternate
  # screen buffer is active. This is used to allow mouse
  # scrolling for applications like `man`.
  #
  # To disable this completely, set `faux_multiplier` to 0.

  # Automatically scroll to the bottom when new text is written
  # to the terminal.
  # auto_scroll: false


# Font configuration (changes require restart)

# Font configuration (changes require restart)
font:
  # The normal (roman) font face to use.
  # Style can be specified to pick a specific face.
  normal:
    # family: Iosevka
    style: Light
    family: "Fira Code"
    # family: Hack Nerd Font Mono
    # family: "Source Code Pro"
    # style: Retina

  # The bold font face
  bold:
    # family: Iosevka
    style: Medium
    family: "Fira Code"
     # family: Hack Nerd Font Mono
    # family: "Source Code Pro"

  # The italic font face
  italic:
    # family: Iosevka
    style: "Light Italic"
    # style: "Light Oblique"
    family: "Fira Code"
    # family: Hack Nerd Font Mono
    # family: "Source Code Pro"
    # style: "Medium Italic"

  # Point size of the font
  size: 13.0

  # Offset is the extra space around each character. offset.y can be thought of
  # as modifying the linespacing, and offset.x as modifying the letter spacing.
  offset:
    x: 0
    y: 0

  # Glyph offset determines the locations of the glyphs within their cells with
  # the default being at the bottom. Increase the x offset to move the glyph to
  # the right, increase the y offset to move the glyph upward.
  glyph_offset:
    x: 0
    y: 0

  # Thin stroke font rendering (macOS only)
  #
  # Thin strokes are suitable for retina displays, but for non-retina you
  # probably want this set to false.
  #
  # macOS >= 10.14.x:
  #
  # If the font quality on non-retina display looks bad then set
  # `use_thin_strokes` to `true` and enable font smoothing by running the
  # following command:
  #   `defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`
  #
  # This is a global setting and will require a log out or restart to take
  # effect.
  use_thin_strokes: true

# When true, bold text is drawn using the bright variant of colors.
draw_bold_text_with_bright_colors: false

# Use custom cursor colors. If true, display the cursor in the cursor.foreground
# and cursor.background colors, otherwise invert the colors of the cursor.
custom_cursor_colors: true


# Colors (Gruvbox dark)
colors:
  primary:
    # hard contrast background - '#1d2021'
    background:        &gruvbox_dark_bg '#282828'
    # soft contrast background - '#32302f'
    foreground:        '#ebdbb2'
    bright_foreground: '#fbf1c7'
    dim_foreground:    '#a89984'
  cursor:
    text:   CellBackground
    cursor: CellForeground
  vi_mode_cursor:
    text:   CellBackground
    cursor: CellForeground
  # search:
  #   matches:
  #     foreground: '#000000'
  #     background: '#ffffff'
  #   focused_match:
  #    foreground: CellBackground
  #    background: CellForeground
  #   bar:
  #     background: ''
  #     foreground: ''
  # line_indicator:
  #   foreground: None
  #   background: None
  selection:
    text:       CellBackground
    background: CellForeground
  bright:
    black:   '#928374'
    red:     '#fb4934'
    green:   '#b8bb26'
    yellow:  '#fabd2f'
    blue:    '#83a598'
    magenta: '#d3869b'
    cyan:    '#8ec07c'
    white:   '#ebdbb2'
  normal:
    black:   *gruvbox_dark_bg
    red:     '#cc241d'
    green:   '#98971a'
    yellow:  '#d79921'
    blue:    '#458588'
    magenta: '#b16286'
    cyan:    '#689d6a'
    white:   '#a89984'
  dim:
    black:   '#32302f'
    red:     '#9d0006'
    green:   '#79740e'
    yellow:  '#b57614'
    blue:    '#076678'
    magenta: '#8f3f71'
    cyan:    '#427b58'
    white:   '#928374'
  # indexed_colors: []

