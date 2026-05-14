" --- GENERAL ---
set nocompatible            " Disable Vi compatibility
set encoding=utf-8          " Set standard encoding
set history=500             " Increase command history

" --- INTERFACE ---
set number                  " Show line numbers
set relativenumber          " Use relative line numbers for easier jumps
set cursorline              " Highlight current line
set showcmd                 " Show incomplete commands in status line
set wildmenu                " Visual autocomplete for command menu
set laststatus=2            " Always show status line

" --- EDITING & INDENTATION ---
set expandtab               " Use spaces instead of tabs
set shiftwidth=4            " Indentation size (4 spaces)
set softtabstop=4           " Number of spaces for a tab press
set autoindent              " Keep indentation from previous line
set smartindent             " Language-aware indentation

" --- SEARCH ---
set incsearch               " Search as you type
set hlsearch                " Highlight search results
set ignorecase              " Case-insensitive search...
set smartcase               " ...unless uppercase is used

" --- FILES ---
set nobackup                " Disable backup files
set noswapfile              " Disable .swp files (prevents recovery prompts)
set undofile                " Maintain undo history across sessions

" --- MAPPINGS ---
" Set Leader to Space to match Helix/VSCode logic
let mapleader = " "

" Clear search highlight with Space + Enter
nnoremap <leader><CR> :noh<CR>

" Quick save with Space + w
nnoremap <leader>w :w<CR>
