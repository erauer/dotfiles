-- init.lua

vim.g.polyglot_disabled={'css'};

require("install-plugins")

-- source old vimscript
vim.cmd("source ~/.config/nvim/old-init.vim")

-- require `new_config.lua` from the nvim/lua folder:
require("new-init")
