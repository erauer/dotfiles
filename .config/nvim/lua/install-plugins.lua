local vim = vim
local function plug(path, config)
  vim.validate {
    path = {path, 's'},
    config = {config, vim.tbl_islist, 'an array of packages'},
  }
  vim.fn["plug#begin"](path)
  for _, v in ipairs(config) do
    if type(v) == 'string' then
      vim.fn["plug#"](v)
    elseif type(v) == 'table' then
      local p = v[1]
      assert(p, 'Must specify package as first index.')
      v[1] = nil
      vim.fn["plug#"](p, v)
      v[1] = p
    end
  end
  vim.fn["plug#end"]()
end

plug(tostring(os.getenv("HOME")) .. '/.vim/plugged', {
  'tpope/vim-commentary',
  'tpope/vim-commentary',
  'tpope/vim-fugitive',
  'tpope/vim-sensible',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  'tpope/vim-vinegar',
  'tpope/vim-endwise',
  'tpope/vim-rhubarb',
  'tpope/vim-vinegar',
  'tpope/vim-unimpaired',

  'sbdchd/neoformat',

  'vim-airline/vim-airline',
  'vim-airline/vim-airline-themes',
  'airblade/vim-gitgutter',

  -- Color
  'mhartington/oceanic-next',
  'gh123man/vim-atom-dark-modded-256',
  {'nanotech/jellybeans.vim', ['tag'] = 'v1.7' },
  'joshdick/onedark.vim',
  'kassio/neoterm',
  'rakr/vim-one',
  'skbolton/embark',
  'folke/tokyonight.nvim',
  'drewtempelmeyer/palenight.vim',

  'xolox/vim-misc', 'xolox/vim-session',
  'honza/vim-snippets',


  'rking/ag.vim', 'jaawerth/nrun.vim',

  'lambdalisue/suda.vim',
  'junegunn/fzf.vim',

  'termhn/i3-vim-nav',
  'vimwiki/vimwiki',
  {'suan/vim-instant-markdown', ['for'] = 'markdown'},

  'elixir-lang/vim-elixir', 'carlosgaldino/elixir-snippets', 'slashmili/alchemist.vim', 'powerman/vim-plugin-AnsiEsc',

  'jimenezrick/vimerl',

  'hail2u/vim-css3-syntax', 'gorodinskiy/vim-coloresque', 'tpope/vim-haml', 'mattn/emmet-vim',

  -- PlantUML

  'scrooloose/vim-slumlord',
  'jelera/vim-javascript-syntax',
  {'fatih/vim-go', ['do'] = 'GoUpdateBinaries' },


  'sheerun/vim-polyglot',
  {'neoclide/coc.nvim', ['branch'] = 'release'},
  {'elixir-lsp/coc-elixir', ['do'] = 'yarn install && yarn prepack'},
  {'neoclide/coc-tsserver', ['do'] = 'yarn install --frozen-lockfile'},
  {'fannheyward/coc-rust-analyzer', ['do'] = 'yarn install --frozen-lockfile'},
  {'iamcco/coc-diagnostic', ['do'] = 'yarn install --frozen-lockfile && yarn build'},

  'nvim-lua/popup.nvim',
  'nvim-lua/plenary.nvim',
  'nvim-telescope/telescope.nvim',

  'airblade/vim-rooter',

})

