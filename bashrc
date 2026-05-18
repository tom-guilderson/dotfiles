alias l='ls -lF'
alias la='ls -AlF'
alias lah='ls -AlhF'

# put ~/.cargo/bin in the path
# put ~/.netcoredbg in the path
# put ~/.local/bin in the path
export PATH="${HOME?}/.cargo/bin:${HOME}/.netcoredbg:${HOME}/.local/bin:${PATH}"

# set prompt
export PS1="\u@\h:\W $ "

# do not use the out of data system emacs - use the one in Applications
# use -nw to run in terminal by default
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
alias xemacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
# export EDITOR='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'

alias emacs="emacs -nw"
alias xemacs="emacs"
export EDITOR="emacs -nw"

# for brain dead things that just dump me into vi ...
alias vi="emacs -nw"
alias vim="emacs -nw"

# githubtoken needed for docker build
if [ -f ~/.githubtoken ]; then
    . ~/.githubtoken
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
        ssh-add
    else
        . $HOME/.ssh/$HOSTNAME.ssh-agent
    fi
fi

# ################################################################################ #
# run this to restore the connection to the ssh agent inside tmux                  #
#                                                                                  #
# this is usually only needed when forwarding the ssh-agent via "ssh -A user@host" #
#                                                                                  #
# if we have local keys, the previous block will load the local keys into          #
# a local ssh-agent.                                                               #
# ################################################################################ #
function fixssh() {
  for key in SSH_AUTH_SOCK SSH_CONNECTION SSH_CLIENT; do
    if (tmux show-environment | grep "^${key}" > /dev/null); then
      value=`tmux show-environment | grep "^${key}" | sed -e "s/^[A-Z_]*=//"`
      export ${key}="${value}"
    fi
  done
}
