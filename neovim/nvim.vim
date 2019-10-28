" Automatically install Vim Plug
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

" General nvim settings
    lang en_US.UTF-8
	let mapleader=","
	set hidden
	set noshowmode
	set mouse=a
	set dir='/tmp/,~/tmp,/var/tmp,.'
	" Tab and indent
	set expandtab tabstop=4
	set shiftwidth=4
	set foldmethod=indent

	set relativenumber number
    set signcolumn=yes
	set cursorline
	set sidescroll=1
	set conceallevel=0
	set colorcolumn=88
	set breakindent
	set breakindentopt=shift:2,sbr
	set lbr formatoptions+=l " Ensures word-wrap does not split words
	" Search config
	set ignorecase smartcase
    set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
    set shortmess+=c " don't give |ins-completion-menu| messages.
    " Show trailing whitepace and spaces before a tab:
    :highlight ExtraWhitespace ctermbg=red guibg=red
    :autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/


call plug#begin('~/.local/share/nvim/plugged')
	Plug 'tpope/vim-sensible'
	Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-commentary'
	Plug 'tpope/vim-abolish'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-eunuch'
	Plug 'junegunn/fzf', {'dir': '~/.fzf/', 'do': './install -all'}
	Plug 'junegunn/fzf.vim'
    Plug 'vimwiki/vimwiki'
    Plug 'junegunn/goyo.vim'
	Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
	Plug 'yuttie/comfortable-motion.vim'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'metakirby5/codi.vim'
    " Tmux
	Plug 'christoomey/vim-tmux-navigator'
	Plug 'tmux-plugins/vim-tmux'
    Plug 'tmux-plugins/vim-tmux-focus-events'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
	Plug 'honza/vim-snippets'
	Plug 'wellle/tmux-complete.vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'majutsushi/tagbar'
	" Python
	Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    " Swift
    Plug 'jph00/swift-apple'
	" Visual
    Plug 'szw/vim-maximizer'
    " Plug 'pseewald/vim-anyfold'
	Plug 'itchyny/lightline.vim'
	Plug 'mhinz/vim-signify'
	Plug 'sheerun/vim-polyglot'
	Plug 'arcticicestudio/nord-vim'
    Plug 'junegunn/seoul256.vim'
	Plug 'ryanoasis/vim-devicons'
call plug#end()

" Fzf.vim
	nnoremap <leader>h :History<CR>
	nnoremap <leader>b :Buffers<CR>
	nnoremap <leader>t :Files<CR>
    nnoremap <leader>gf :GitFiles<CR>
    nnoremap <leader>l :Lines<CR>
	nnoremap <leader>a :Ag<CR>
    nnoremap <leader>rg :Rg<CR>
" NERDTree
    map <C-n> :NERDTreeToggle<CR>
    let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
    let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
    " Disable arrow icons at the left side of folders for NERDTree.
    let g:NERDTreeDirArrowExpandable = "\u00a0"
    let g:NERDTreeDirArrowCollapsible = "\u00a0"
    highlight! link NERDTreeFlags NERDTreeDir

" Comfortable motion
	let g:comfortable_motion_scroll_down_key = "j"
	let g:comfortable_motion_scroll_up_key = "k"
	noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
	noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>
" Coc
    let g:coc_global_extensions = ["coc-python", "coc-snippets", "coc-json", "coc-ccls", "coc-tabnine", "coc-tag", "coc-syntax", "coc-emoji"]
    " Use `[c` and `]c` for navigate diagnostics
    nmap <silent> [c <Plug>(coc-diagnostic-prev)
    nmap <silent> ]c <Plug>(coc-diagnostic-next)
    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> g[ <Plug>(coc-declaration)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')
    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)
    " Remap for format selected region
    vmap <leader>cf  <Plug>(coc-format-selected)
    nmap <leader>cf  <Plug>(coc-format-selected)
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    vmap <leader>ca  <Plug>(coc-codeaction-selected)
    nmap <leader>ca  <Plug>(coc-codeaction-selected)
    " Remap for do codeAction of current line
    nmap <leader>caa  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>cqf  <Plug>(coc-fix-current)
    " Use `:Format` for format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Coc K to show documentation
    function! s:show_documentation()
      if &filetype == 'vim'
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    " Use tab for trigger completion, completion confirm, snippets expand and jump
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
    inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    imap <C-j> <Plug>(coc-snippets-expand-jump)
" tags
    nmap <F8> :TagbarToggle<CR>
    augroup MyGutentagsStatusLineRefresher
        autocmd!
        autocmd User GutentagsUpdating call lightline#update()
        autocmd User GutentagsUpdated call lightline#update()
    augroup END

" Python
	let g:cellmode_tmux_panenumber='1'
    let g:cellmode_default_mappings='0'
    vmap <silent> <C-c> :call RunTmuxPythonChunk()<CR>
	autocmd FileType python nmap <silent> <leader>sr :Semshi rename<CR>
" Signify - Git sign bar
	let g:signify_vcs_list = ['git']
	nnoremap <leader>gt :SignifyToggle<CR>
	nnoremap <leader>gh :SignifyToggleHighlight<CR>
	nnoremap <leader>gr :SignifyRefresh<CR>
	nmap <leader>gj <plug>(signify-next-hunk)
	nmap <leader>gk <plug>(signify-prev-hunk)
" Lightline
	let g:lightline = {
        \ 'colorscheme': 'nord',
		\ 'component': {
		\ },
		\ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'filename', 'modified'] ],
		\   'right': [ [ 'percent' ,'lineinfo' ],
		\              [ 'fileencoding', 'filetype', 'fugitive' ],
        \              [ 'cocstatus', 'gutentags' ] ]
		\ },
		\ 'component_function': {
        \   'gutentags': 'gutentags#statusline',
        \   'cocstatus': 'LightlineCocStatus',
		\   'readonly': 'LightlineReadonly',
		\   'fugitive': 'LightlineFugitive',
        \   'filename': 'LightlineFilename',
		\ },
		\ 'separator': { 'left': '', 'right': '' },
		\ 'subseparator': { 'left': '', 'right': '' },
		\}

	function! LightlineReadonly()
		return &readonly ? '' : ''
	endfunction
	function! LightlineFugitive()
		if exists('*fugitive#head')
			let branch = fugitive#head()
			return branch !=# '' ? ''.branch : ''
		endif
		return ''
	endfunction
	function! LightlineFilename()
		let name = ""
		let subs = split(expand('%'), "/")
		let i = 1
		for s in subs
			let parent = name
			if  i == len(subs)
				let name = parent . '/' . s
			elseif i == 1
				let name = s
			else
				let name = parent . '/' . strpart(s, 0, 2)
			endif
			let i += 1
		endfor
	  return name
	endfunction
    function! LightlineCocStatus()
        let status = coc#status()
        let env = matchstr(status, "(\'.*\':")[2:-3]
        return winwidth(0) > 120 ? status : env
    endfunction
" Theme
    set t_Co=256
	set background=dark
	colorscheme nord

" Mapping
    nnoremap <silent><C-w>m :MaximizerToggle<CR>
    vnoremap <silent><C-w>m :MaximizerToggle<CR>gv
    inoremap <silent><C-w>m <C-o>:MaximizerToggle<CR>
    " Folding and cursors
	nnoremap <space> za
	vnoremap <space> zf
	nnoremap <leader>z zMzvzz
	nnoremap n nzzzv
	nnoremap N Nzzzv
    " Copy
	nnoremap <leader>y "+y
	vnoremap <leader>y "+y
	nnoremap <leader>p "+p
	vnoremap <leader>p "+p
    nnoremap <esc> :noh<return><esc>
    tnoremap <Esc> <C-\><C-n>:q!<CR>
