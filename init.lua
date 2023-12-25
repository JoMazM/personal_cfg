----------------------------
-- Global configuration
----------------------------
vim.cmd([[
filetype plugin indent on  " Filetype auto-detection
syntax on                  " Syntax highlighting

set noswapfile             " NoShada file. FOr portable cfg
set tabstop=4
set shiftwidth=4
set expandtab              " Use spaces instead of tabs
set smarttab               " 
set shiftround             " Tab/Shifting moves to cloests tabstop
set autoindent             " Match indents on new lines.
set smartindent            " Smart indent
" set foldmethod=syntax

" Leader Configuration
let mapleader = " " " Map leader to space
let timeoutlen =  500 " timeout in miliseconds

" Clipboard configuration
set clipboard=unnamedplus
]])

if vim.fn.exists('g:vscode') ~= 0 then
-- VSCode specific configuration
else
-- Nevoim specific configuration
    vim.cmd([[
        set number
        set list
        set listchars=
        set listchars+=tab:→\ 
        set listchars+=trail:·
        set listchars+=extends:»
        set listchars+=precedes:«
        set listchars+=nbsp:⣿
        set wildmenu
        set wildmode=list:longest,list:full " Wild menu cfg
    
        " Set completeopt to have a better completion experience 
        set completeopt=menuone,noinsert,noselect 
        " Enable completions as you type 
        let g:completion_enable_auto_popup = 1
    ]])
end
----------------------------------
-- Helper functions
-- -------------------------------
function vim.getVisualSelection()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end
function vim.getVisualSelectionSurrounded()
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})

    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return "\"" .. text .. "\""
    else
        return ''
    end
end
function vim.setTerminalKeymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end


------------------------
--- Plugin Configuration
------------------------
local Plug = nil
if vim.fn.has("linux") == 1 then
    Plug = vim.fn['plug#']
    vim.call('plug#begin')
else
    if vim.fn.exists("g:vscode") ~= 0 then
        vim.cmd('source c:/tools/XDG_DATA_HOME/nvim-data/site/autoload/plug.vim')
    end
    local Plug = vim.fn['plug#']
    vim.call('plug#begin', '~/../../tools/XDG_DATA_HOME/nvim/plugged')
end

-- Global plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'

--IDE-Specific configuration
if vim.fn.exists("g:vscode") ~= 0 then
else
    Plug 'tpope/vim-commentary'
    Plug 'vim-airline/vim-airline' 
    Plug 'vim-airline/vim-airline-themes' 
    Plug 'davidhalter/jedi-vim'
    Plug 'preservim/nerdtree' -- File explorer
    Plug 'tpope/vim-markdown'
    Plug 'stevearc/dressing.nvim' -- UI improvement
    Plug 'rust-lang/rust.vim' -- Rust language support
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim' -- Buffer/grep window functionality
    Plug 'desdic/agrolens.nvim' -- Telescope tree-sitter picker
    Plug 'tom-anders/telescope-vim-bookmarks.nvim' -- Telescope vim bookmarks
    Plug 'MattesGroeger/vim-bookmarks' -- Bookmarks plugin
    Plug 'nvim-telescope/telescope-live-grep-args.nvim'
    Plug 'nvim-telescope/telescope-file-browser.nvim'
    
    Plug 'folke/noice.nvim' -- Command-line replacement
    Plug 'MunifTanjim/nui.nvim' -- Dependency from noice
    Plug 'rcarriga/nvim-notify' -- Dependency from noice

    Plug 'xiyaowong/transparent.nvim' -- Theme customization
    Plug 'marko-cerovac/material.nvim' -- Theme customization
    Plug 'folke/tokyonight.nvim' -- Theme customization
    Plug 'navarasu/onedark.nvim' -- Theme customization

    -- OS-Specific plugins
    -- Plug('rebelot/terminal.nvim')
    Plug('akinsho/toggleterm.nvim', {tag = '*'})
    if vim.fn.has("linux") == 1 then
        Plug 'stevearc/overseer.nvim' -- Task runner 
    end

    -- Language Server Plugins
    Plug 'neovim/nvim-lspconfig'
    Plug 'ziglang/zig.vim'
    Plug 'rubberduck203/aosp-vim' -- Syntax highlight for AOSP files
    Plug 'bfrg/vim-cpp-modern'    -- Improved Syntax highlight
    Plug('nvim-treesitter/nvim-treesitter', {run = [[:TSUpdate]]})
    Plug 'mfussenegger/nvim-dap' -- Debugger Adapter
    Plug 'theHamsta/nvim-dap-virtual-text' -- DAP show inline variable values
    Plug 'rcarriga/nvim-dap-ui' -- DAP Preconfigured UI for DAP
    Plug 'ldelossa/nvim-dap-projects' -- DAP per project cfg
    Plug 'terrastruct/d2-vim' -- Syntax highlight for D2 Diagram language

    ------------------------- 
    --Auto-complete plugins 
    -------------------------
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'ray-x/cmp-treesitter'

    -- For vsnip users.
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'


    -- Always load the vim-devicons as the very last one.
    Plug 'ryanoasis/vim-devicons'
end
vim.call('plug#end')

------------------------------
--- Plugin configuration
-----------------------------
if vim.fn.exists("g:vscode") ~= 0 then
else
    if vim.fn.has("linux") == 1 then
        require("overseer").setup({strategy = "toggleterm",})
    end

    -- Toggleterm configuration
    require('toggleterm').setup({
        open_mapping = '<C-\\>',
        start_in_insert = true,
        -- direction = 'float',
    })
    
    vim.cmd([[
        "vim-airline shows buffer number 
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
        " Nerdtree configuration
        let NERDTreeQuitOnOpen=1
        let NERDTreeShowHidden=1
        
        " Fix for telsecope theme showing in pink
        hi NormalFloat ctermfg=LightGrey
        
        " Set completeopt to have a better completion experience
        set completeopt=menuone,noinsert,noselect
        " Enable completions as you type
        let g:completion_enable_auto_popup = 1
    ]])
    
    ----------------
    --- Telescope
    ----------------
    require "telescope".load_extension("agrolens")
    require "telescope".load_extension("live_grep_args")
    require "telescope".load_extension('vim_bookmarks')
    require "telescope".load_extension('file_browser')

    vim.g.bookmark_save_per_working_dir = 1
    vim.g.bookmark_auto_save = 1

    -- Noice
    require "noice".setup()
    require "telescope".load_extension("noice")
    vim.opt.termguicolors = true
    require("notify").setup({background_colour = "#000000",
                             render = "wrapped-compact",
                             stages = "fade",
                             fps = "60",
                           })
    -------------------
    -- vim-cpp-modern cfg
    -------------------
    -- Disable function highlighting (affects both C and C++ files)
    -- vim.g.cpp_function_highlight = 0
    -- Enable highlighting of C++11 attributes
    vim.g.cpp_attributes_highlight = 1
    -- Highlight struct/class member variables (affects both C and C++ files)
    vim.g.cpp_member_highlight = 1
    -- Put all standard C and C++ keywords under Vim's highlight group 'Statement'
    -- (affects both C and C++ files)
    vim.g.cpp_simple_highlight = 1

    -- LSP Configuration
    local lspconfig = require('lspconfig')
    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        require('completion').on_attach()
    end
    local servers = {'zls'}
    for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
            on_attach = on_attach,
        }
    end
    -------------------------------------
    -- Tree-sitter plugin configuration
    -------------------------------------
    require'nvim-treesitter.configs'.setup {
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua", "cpp", "zig", "vim", "regex", "bash" },
        indent = {
            enable = true
        },
      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,
    
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = false,
    
      -- List of parsers to ignore installing (or "all")
      ignore_install = { "javascript" },
    
      highlight = {
        enable = true,
    
        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "rust" },
    
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    }
    vim.opt.foldmethod="expr"
    vim.opt.foldexpr="nvim_treesitter#foldexpr()"
    -- Fix fold problem when Telescope find file open
    vim.api.nvim_create_autocmd({ "BufEnter" }, { pattern = { "*" }, command = "normal zx zR", })
    vim.cmd([[set nofoldenable]])
    
    ---------------------------
    --- Debugger Configuration
    ---------------------------
    if vim.fn.has("linux") == 1 then
        local dap = require('dap')
        dap.adapters.cppdbg = {
          id = 'cppdbg',
          type = 'executable',
          command = '~/.vscode-server/extensions/ms-vscode.cpptools-1.17.5-linux-x64/debugAdapters/bin/OpenDebugAD7',
        }
    else
        require('nvim-dap-projects').search_project_config()
        require('dapui').setup()
        require('nvim-dap-virtual-text').setup()
        
        local dap = require('dap')
        dap.adapters.lldb = {
            type = 'executable',
            command = 'C:\\tools\\LLVM\\bin\\lldb-vscode.exe',
            name = 'lldb'
        }
        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = 'C:\\tools\\VSCode\\data\\extensions\\ms-vscode.cpptools-1.17.5-win32-x64\\debugAdapters\\bin\\OpenDebugAD7.exe',
            options = {
                detached = false
            }
        }
        dap.configurations.cpp = {
          {
             name = 'Launch',
             -- type = 'cppdbg',
             type = 'lldb',
             request = 'launch',
             args = {},
             program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/zig-out/bin/', 'file')
             end,
             cwd = '${workspaceFolder}',
             stopAtEntry = true,
             -- runInTerminal = true,
             -- miDebuggerPath = 'C:\\tools\\msys64\\mingw64\\bin\\gdb.exe',
          },
        }
        -- dap.configurations.cpp = {
        --   {
        --     name = 'Launch',
        --     type = 'lldb',
        --     request = 'launch',
        --     program = function()
        --       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --     end,
        --     cwd = '${workspaceFolder}',
        --     stopOnEntry = false,
        --     args = {},
        --     runInTerminal = false,
        --   },
        -- }
        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp
        dap.configurations.zig = dap.configurations.cpp
    end

    ---------------------------
    --- Completion Setup - nvim-cmp
    ---------------------------
    local cmp = require('cmp')
    cmp.setup({
        -- completion = {
        --     autocomplete = true,
        -- },
        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-d>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete {},
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
                },
            ['<Tab>'] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                      cmp.select_next_item()
                  else
                      fallback()
                  end
                end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
              end, { 'i', 's' }),
        },
      -- You should specify your *installed* sources.
      sources = {
        { name = 'buffer' },
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'vsnips' },
        { name = 'treesitter' },
      },
    })

end

------------------------------
-- Global Mappings
--
-- :map recursive map. Works in Normal,Visual and Insert
-- :nmap recursive map. Works in Normal
-- :noremap and non-recursive map. Works in Normal,Visual and Insert
-- :nnoremap and non-recursive map. Works in Normal
-- https://neovim.io/doc/user/map.html
------------------------------
if vim.fn.exists("g:vscode") ~= 0 then
    -- Different mappings configured in keybindings.json similar to NERDTree
    vim.keymap.set('','<leader>t', ':call VSCodeNotify(\'workbench.explorer.fileView.focus\')<CR>')

    -- Get folding working with vscode neovim plugin
    -- vim.keymap.set('n', 'zM', ':call VSCodeNotify(\'editor.foldAll\')<CR>')
    -- vim.keymap.set('n', 'zR', ':call VSCodeNotify(\'editor.unfoldAll\')<CR>')
    -- vim.keymap.set('n', 'zc', ':call VSCodeNotify(\'editor.fold\')<CR>')
    -- vim.keymap.set('n', 'zC', ':call VSCodeNotify(\'editor.foldRecursively\')<CR>')
    -- vim.keymap.set('n', 'zo', ':call VSCodeNotify(\'editor.unfold\')<CR>')
    -- vim.keymap.set('n', 'zO', ':call VSCodeNotify(\'editor.unfoldRecursively\')<CR>')
    -- vim.keymap.set('n', 'za', ':call VSCodeNotify(\'editor.toggleFold\')<CR>')

    --Above mappings don't work. Need to investigate. Use default
    vim.cmd([[
    nnoremap zM :call VSCodeNotify('editor.foldAll')<CR>
    nnoremap zR :call VSCodeNotify('editor.unfoldAll')<CR>
    nnoremap zc :call VSCodeNotify('editor.fold')<CR>
    nnoremap zC :call VSCodeNotify('editor.foldRecursively')<CR>
    nnoremap zo :call VSCodeNotify('editor.unfold')<CR>
    nnoremap zO :call VSCodeNotify('editor.unfoldRecursively')<CR>
    nnoremap za :call VSCodeNotify('editor.toggleFold')<CR>
    
    function! MoveCursor(direction) abort
        if(reg_recording() == '' && reg_executing() == '')
            return 'g'.a:direction
        else
            return a:direction
        endif
    endfunction
    
    nmap <expr> j MoveCursor('j')
    nmap <expr> k MoveCursor('k')
    
    nmap <expr> <Down> MoveCursor('j')
    nmap <expr> <Up> MoveCursor('k')
    ]])
else
    ----------------------------------
    --Split navigation

    -- vim.keymap.set('n', '<leader>h', '<C-W><C-H>')
    -- vim.keymap.set('n', '<leader>j', '<C-W><C-J>')
    -- vim.keymap.set('n', '<leader>k', '<C-W><C-K>')
    -- vim.keymap.set('n', '<leader>l', '<C-W><C-L>')
    -- -- Move buffer to other split 
    -- vim.keymap.set('n', '<leader>wh', '<C-W>H')
    -- vim.keymap.set('n', '<leader>wj', '<C-W>J')
    -- vim.keymap.set('n', '<leader>wk', '<C-W>K')
    -- vim.keymap.set('n', '<leader>wl', '<C-W>L')
    vim.keymap.set('n', '<C-W><C-H>', '<C-W>H',{desc = "Move buffer to left split"})
    vim.keymap.set('n', '<C-W><C-J>', '<C-W>J',{desc = "Move buffer to bottom split"})
    vim.keymap.set('n', '<C-W><C-K>', '<C-W>K',{desc = "Move buffer to top split"})
    vim.keymap.set('n', '<C-W><C-L>', '<C-W>L',{desc = "Move buffer to right split"})
    -- Increase/ Decrease splits 
    vim.keymap.set('n', '<leader><Right>', '<C-W>>',{desc = "Adjust buffer size to the right"})
    vim.keymap.set('n', '<leader><Down>', '<C-W>-', {desc = "Adjust buffer size bottom"})
    vim.keymap.set('n', '<leader><Up>', '<C-W>+',   {desc = "Adjust buffer size up"})
    vim.keymap.set('n', '<leader><Left>', '<C-W><', {desc = "Adjust buffer size down"})

    ----------------------------------------
    -- Telescope plugin Using Lua functions
    vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, {desc = "Find files with Telescope"})
    vim.keymap.set("n", "<leader>fg", require('telescope').extensions.live_grep_args.live_grep_args, {desc = "Grep files with Telescope"})
    vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, {desc = "Show open buffers with Telescope"})
    vim.keymap.set('n', '<leader>fm', require('telescope').extensions.vim_bookmarks.all, {desc = "Show bookmarks with Telescope"})
    vim.keymap.set('n', '<leader>ft', require('telescope').extensions.file_browser.file_browser, {desc = "Telescope file browser"})
    vim.keymap.set('n', '<leader>fh', function() require('telescope.builtin').builtin({include_extensions = true}) end, {desc = "List Telescope builtin pickers"})
    -- Visual Mode - Pick selection
    vim.keymap.set('v', '<leader>ff', function()
        local text = vim.getVisualSelection()
        require('telescope.builtin').current_buffer_fuzzy_find({ default_text = text })
        end, 
        { noremap = true, silent = true, desc = "Find selection in current buffer using Telescope" })
    vim.keymap.set('v', '<leader>fg', function()
        local text = vim.getVisualSelectionSurrounded()
        require('telescope').extensions.live_grep_args.live_grep_args({default_text = text})
        -- require('telescope.builtin').live_grep({ default_text = text })
        end, 
        { noremap = true, silent = true,desc = "Grep selection using Telescope" })
    
    -------------------------
    -- DAP keymap
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end, {desc = "DAP: Continue"})
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, {desc = "DAP: Step over"})
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, {desc = "DAP: Step into"})
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, {desc = "DAP: Step out"})
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, {desc = "DAP: Toggle breakpoint"})
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, {desc = "DAP: Set breakpoint"})
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, {desc = "DAP: Set breakpoint"})
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, {desc = "DAP: REPL Open"})
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, {desc = "DAP: Run last"})
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end, {desc = "DAP: UI Widget"})
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end, {desc = "DAP: UI Widget preview"})
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end, {desc = "DAP: UI Widget Frame"})
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end, {desc = "DAP: UI Widget Scopes"})

    --------------------------------
    -- Telescope
    --------------------
    --- NERDTree
    vim.keymap.set('', '<leader>tt',  ':NERDTreeToggle<CR>', {desc = "Toggle Nerdtree"})
    vim.keymap.set('', '<leader>tf', ':NERDTreeFind<CR>', {desc = "Find current file wiht Nerdtree"})

    ---------------------------------
    --- Toggleterm
    -- if you only want these mappings for toggle term use term://*toggleterm#* instead of term://*
    local Terminal  = require('toggleterm.terminal').Terminal
    vim.cmd('autocmd! TermOpen term://*toggleterm#* lua vim.setTerminalKeymaps()')
    if vim.fn.has("linux") == 1 then
        local bash = Terminal:new({ cmd = "bash", hidden = false })

        function _bash_toggle()
            bash:toggle()
        end
        vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>lua _bash_toggle()<CR>", {noremap = true, silent = true})
    else
        local cmder = Terminal:new({ cmd = "cmd.exe /K C:/tools/cmder/vendor/init.bat  /f /t", hidden = true })

        function _cmder_toggle()
            cmder:toggle()
        end
        vim.api.nvim_set_keymap("n", "<C-\\>", "<cmd>lua _cmder_toggle()<CR>", {noremap = true, silent = true})
    end
end
------------------------------------
-- Colorscheme configuration
-- Check also :TransparentEnable
-- Call after plug to find the path
------------------------------------
if vim.fn.exists('g:vscode') ~= 0 then
else
    vim.cmd([[
    let g:onedark_config = {
        \ 'style': 'darker',
    \}
    colorscheme onedark

    "colorscheme tokyonight
    " There are also colorschemes for the different styles
    " colorscheme tokyonight-night
    " colorscheme tokyonight-storm
    "colorscheme tokyonight-day
    " colorscheme tokyonight-moon
    " colorscheme material
    " lua vim.g.material_style = "deep ocean"
    " lua vim.g.material_style = "oceanic"
    " lua vim.g.material_style = "darker"
    " lua vim.g.material_style = "lighter"
    " lua vim.g.material_style = "palenight"
    " Check also :TransparentToggle
    ]])
end
