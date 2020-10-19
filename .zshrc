# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/eric/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.config/zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [ -f $HOME/.config/zsh/themes/erauer.zsh-theme ]; then
  ZSH_THEME="erauer"
else
  ZSH_THEME="robbyrussell"
fi


# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  vi-mode
  mix
  wd
  history
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#  export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias cat='bat'

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Autoload custom functions

fpath=($HOME/.config/zsh/functions $fpath)
fdir=$HOME/.config/zsh/functions
for func in $fdir/[^_.]*(N.:t); do
  autoload -Uz $func
done
unset fdir func

source $HOME/.asdf/asdf.sh

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv'

export GOPATH=~/Documents/projects/go

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH=$GOPATH/bin:$GOPATH/bin/linux_amd64:$HOME/.local/bin:$PATH

export GIT_AUTO_FETCH_INTERVAL=86400

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias auth='ykman -d 6506058 oath code "$(ykman -d 6506058  oath list | fzf)"'
alias wdd='wd "$(wd list | fzf | awk '\''{print $1}'\'')"'

# added by travis gem
[ -f /home/eric/.travis/travis.sh ] && source /home/eric/.travis/travis.sh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/eric/Documents/projects/sc01/sc01-plt-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/eric/Documents/projects/sc01/sc01-plt-api/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/eric/Documents/projects/sc01/sc01-plt-api/node_modules/tabtab/.completions/sls.zsh ]] && . /home/eric/Documents/projects/sc01/sc01-plt-api/node_modules/tabtab/.completions/sls.zsh


export PATH=$PATH:$HOME/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"


export AWS_PROFILE=bcd
export AWS_DEFAULT_REGION=us-west-2
export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"

eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK

alias status="echo $?"
eval $(hub alias -s)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/eric/Documents/tools/google-cloud-sdk/path.zsh.inc' ]; then . '/home/eric/Documents/tools/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/eric/Documents/tools/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/eric/Documents/tools/google-cloud-sdk/completion.zsh.inc'; fi

export SAM_CLI_TELEMETRY=0

alias vi=nvim
eval $(thefuck --alias)
#eval "$(direnv hook zsh)"
