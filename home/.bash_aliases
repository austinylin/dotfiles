function find_git_branch {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head == ref:\ refs/heads/* ]]; then
                git_branch=" (${head#*/*/})"
            elif [[ $head != '' ]]; then
                git_branch=' (detached)'
            else
                git_branch=' (unknown)'
            fi
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\e[1;36m\]\$git_branch\[\033[00m\]\$ "

alias ll='ls -alFh'

if [ -n "$SSH_AUTH_SOCK" ]; then
screen_ssh_agent="/tmp/${USER}-screen-ssh-agent.sock"
if [ ${STY} ]; then
if [ -e ${screen_ssh_agent} ]; then
export SSH_AUTH_SOCK=${screen_ssh_agent}
fi
else
ln -snf ${SSH_AUTH_SOCK} ${screen_ssh_agent}
fi
fi
