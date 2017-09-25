fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}*"
zstyle ':vcs_info:*' formats "%F{green}(%c%u%b%f%F{green})%f "
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }
PROMPT='%F{red}%~%f ${vcs_info_msg_0_}%F{blue}$%f '
PROMPT2='%F{red}%_%f %F{blue}~%f '
SPROMPT='%F{red}%r is correct? [n,y,a,e]:%f %F{blue}$%f '
[ -n '${REMOTEHOST}${SSH_CONNECTION}' ] &&

  HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

zstyle ':completion:*:default' menu select # select by arrow key
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

setopt auto_cd
setopt auto_pushd
setopt correct
setopt list_packed
setopt nolistbeep
setopt noautoremoveslash
setopt hist_verify

typeset -U path cdpath fpath manpath # do not add the registered path

# ##### ##### ##### ##### #####
# PATH
export PATH=$PATH:~/bin

# ##### ##### ##### ##### #####
# Alias
setopt complete_aliases
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim -g "$@"'
alias ls='ls -vFG'
alias l='ls -la'
alias la="ls -a"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"

alias chrome="open -a /Applications/Google\ Chrome.app"

if type rmtrash > /dev/null 2>&1; then
  alias rm='rmtrash'
fi

# ##### ##### ##### ##### #####
# Golang
export GOPATH=$HOME/Develop/repositories
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# ##### ##### ##### ##### #####
# Function
chpwd() {
  ls_abbrev
}
ls_abbrev() {
  if [[ ! -r $PWD ]]; then
    return
  fi
  # -a : Do not ignore entries starting with ..
  # -C : Force multi-column output.
  # -F : Append indicator (one of */=>@|) to entries.
  local cmd_ls='ls'
  local -a opt_ls
  opt_ls=('-aCF' '--color=always')
  case "${OSTYPE}" in
    freebsd*|darwin*)
      if type gls > /dev/null 2>&1; then
        cmd_ls='gls'
      else
        # -G : Enable colorized output.
        opt_ls=('-aCFG')
      fi
      ;;
  esac

  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS command $cmd_ls ${opt_ls[@]} | sed $'/^\e\[[0-9;]*m$/d')

  local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')

  if [ $ls_lines -gt 10 ]; then
    echo "$ls_result" | head -n 5
    echo '...'
    echo "$ls_result" | tail -n 5
    echo "$(command ls -1 -A | wc -l | tr -d ' ') files exist"
  else
    echo "$ls_result"
  fi
}

eval `ssh-agent`
ssh-add ~/.ssh/id_rsa

# eval "$(docker-machine env dev)"

# aws cli
source /usr/local/bin/aws_zsh_completer.sh

# rbenv
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

# ##### ##### ##### ##### #####
# peco
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

