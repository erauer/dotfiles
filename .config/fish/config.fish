# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish
source ~/.asdf/asdf.fish

set fish_greeting
set fish_key_bindings fish_vi_key_bindings

set -gx LSCOLORS gxfxcxdxbxegedabagacad


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/erauer/.asdf/installs/nodejs/6.10.0/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish ]; and . /Users/erauer/.asdf/installs/nodejs/6.10.0/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/erauer/.asdf/installs/nodejs/6.10.0/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish ]; and . /Users/erauer/.asdf/installs/nodejs/6.10.0/.npm/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.fish