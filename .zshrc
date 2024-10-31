# ~/.zshrc: executed by zsh for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Prevent duplicate entries and ignore lines starting with space in history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Append to the history file, don't overwrite it
setopt APPEND_HISTORY

# Set history size
HISTSIZE=1000
SAVEHIST=2000

# Enable recursive globbing with `**`
setopt EXTENDED_GLOB

# make `less` more friendly for non-text input files
# [[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot environment (used in the prompt)
if [[ -z "$debian_chroot" && -r /etc/debian_chroot ]]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Uncomment for a colored prompt, if the terminal supports it
# force_color_prompt=yes

if [[ -n "$force_color_prompt" ]]; then
    if [[ -x /usr/bin/tput ]] && tput setaf 1 &>/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [[ "$color_prompt" = yes ]]; then
    PROMPT='${debian_chroot:+($debian_chroot)}%F{green}%n@%m%f:%F{blue}%~%f$ '
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~$ '
fi

# Removing unwanted characters from prompt when debian_chroot is empty
PROMPT="${debian_chroot:+($debian_chroot)}%F{green}%n@%m%f:%F{blue}%~%f$ "

# Set xterm title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        precmd() {
            print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a"
        }
        ;;
    *)
        ;;
esac

# Enable color support of ls and add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'
    # alias grep='grep --color=auto'
    # alias fgrep='fgrep --color=auto'
    # alias egrep='egrep --color=auto'
fi

# Colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Load aliases from ~/.zsh_aliases if it exists
if [[ -f ~/.zsh_aliases ]]; then
    source ~/.zsh_aliases
fi

# Enable programmable completion
autoload -Uz compinit
compinit

# Set FZF default command to include hidden files
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

# Add directories to PATH if they exist
pathCandidates=(
  /usr/local/go/bin
  ~/tools
  ~/go/bin
  ~/.fly/bin
  ~/.cargo/bin
  ~/swift/usr/bin
  /opt/homebrew/bin
)

for dir in $pathCandidates; do
  [[ -d $dir ]] && path=($dir $path)
done
export PATH

