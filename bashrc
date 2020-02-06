alias l='ls -lF'
alias la='ls -AlF'
alias lah='ls -AlhF'

# put ~/go/bin in the path
export PATH="${HOME?}/bin:${HOME?}/go/bin:${PATH?}"

# do not use the out of data system emacs - use the one in Applications
# use -nw to run in terminal by default
# alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
# alias xemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
# export EDITOR='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

alias emacs="${HOME?}/bin/emacs -nw"
alias xemacs="${HOME?}/bin/emacs"
export EDITOR="${HOME?}/bin/emacs -nw"

# for brain dead things that just dump me into vi ...
alias vi="${HOME?}/bin/emacs -nw"
alias vim="${HOME?}/bin/emacs -nw"

if command -v most > /dev/null 2>&1; then
    export PAGER="most"
fi

# source in dd specific stuff
if [ -r ~/.bash_dd ]; then
    source ~/.bash_dd
fi

#######################################################################
# ssh-agent                                                           #
#######################################################################
if [ "$TERM" != "dumb" ]; then
    ssh_agent_pid_1=`pgrep -u $UID ssh-agent`
    if [ -z "$ssh_agent_pid_1" ]; then
        if [ -z "$DISPLAY" ]; then
            export DISPLAY=foo
        fi
        eval `/usr/bin/ssh-agent | tee $HOME/.ssh/$HOSTNAME.ssh-agent`
        ssh-add -K -A
    else
        . $HOME/.ssh/$HOSTNAME.ssh-agent
    fi
fi

# run this to restore the connection to the ssh agent
function fixssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}
