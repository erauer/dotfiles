function {
    if [[ -n "$SSH_CLIENT" ]]; then
        PROMPT_HOST="($HOST) "
    else
        PROMPT_HOST=''
    fi
}

PROMPT="%(?:%{$fg_bold[green]%}${PROMPT_HOST}➜ :%{$fg_bold[red]%}➜ )"
PROMPT+=' %{$fg[yellow]%}%c%{$reset_color%} $(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
