# ##### ##### ##### ##### #####
# Path settings.
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home
path=($JAVA_HOME/bin $path)

# ##### ##### ##### ##### #####
# Alias settings.
# alias vim='/Applications/MacVim.app/Contents/MacOS/mvim -v'
alias vim='/Applications/MacVim.app/Contents/MacOS/mvim'
alias ls='ls -vFG'
alias chrome="open -a /Applications/Google\ Chrome.app"
if type rmtrash > /dev/null 2>&1; then
  alias rm='rmtrash'
fi

# ##### ##### ##### ##### #####
# Function settings.
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

# ##### ##### ##### ##### #####
# rbenv settings.
# rbenv rehash

# ##### ##### ##### ##### #####
# Python settings.
if type pyenv > /dev/null 2>&1; then
    # export PIP_REQUIRE_VIRTUALENV=true
    eval "$(pyenv init -)"
fi

# ##### ##### ##### ##### #####
# boot2docker settings.
if type boot2docker > /dev/null 2>&1; then
  export DOCKER_HOST=tcp://192.168.59.103:2376
  export DOCKER_CERT_PATH=~/.boot2docker/certs/boot2docker-vm
  export DOCKER_TLS_VERIFY=1
  # $(boot2docker shellinit) > /dev/null 2>&1
fi

# ##### ##### ##### ##### #####
# Google cloud SDK settings.
# The next line updates PATH for the Google Cloud SDK.
if [ -e "/Users/DaisukeTsuji" ]; then
    source '/Users/DaisukeTsuji/Develop/google-cloud-sdk/path.zsh.inc'
    # The next line enables bash completion for gcloud.
    source '/Users/DaisukeTsuji/Develop/google-cloud-sdk/completion.zsh.inc'
fi

# ##### ##### ##### ##### #####
# Ctags settings.
tagsCmd='ctags --languages=php -f'
tagsVariable=''
tagsVariable=$tagsVariable"cd $HOME/Develop/medpeer-2014;$tagsCmd $HOME/.vim/tags/medpeer.tags $HOME/Develop/medpeer-2014;"
alias TAGS=$tagsVariable

export GOPATH=$HOME/Develop/golang
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

