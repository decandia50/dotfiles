# .profile

# Terminal size checking
shopt -s checkwinsize

# Make bash send a hangup so SSH doesn't hang
shopt -s huponexit

# PATH
PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/local/sbin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
# My personal stuff
PATH=$PATH:~/utils
PATH=$PATH:~/bin
export PATH

# Make sure my editor is right
EDITOR=vim
export EDITOR

# SVN stuff
export SVN_EDITOR=$EDITOR

# CVS stuff
CVS_RSH=srsh
export CVS_RSH

# Fix my terminal so colors work everywhere
OS=`uname -s | tr "[:upper:]" "[:lower:]"`
if [ "${OS}" == "linux" ]; then
  export VIMTERM=linux
  # I don't want UTF-8 in my Linux terminal.
  export LANG=en_US
elif [ "${OS}" == "sunos" ]; then
  export VIMTERM=xtermc
else
  export VIMTERM=$TERM
fi

# Handy aliases
alias vi='vim -T $VIMTERM'
alias less='less -R'
alias ssh='ssh -X'
alias ll='ls -l'
alias la='ls -la'
# Typo handling
alias grpe='grep'
alias gerp='grep'
# For Fun
alias myfortune='MYFORTUNE=`fortune` && echo -e "\e[1;33m${MYFORTUNE}\e[0m"'

# Fancy grep with color
export GREP_OPTIONS="--color=auto"

# Set the Xterm title to the current hostname
PROMPT_COMMAND='echo -ne "\033]0;$(uname -n)\007"'

# Define some colors to use in our prompt
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BROWN='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
LGRAY='\[\033[0;37m\]'
DGRAY='\[\033[1;30m\]'
LRED='\[\033[1;31m\]'
LGREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LBLUE='\[\033[1;34m\]'
LPURPLE='\[\033[1;35m\]'
LCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]' # No Color
REDBG='\[\033[41m\]'

# Fix my prompt
if [ "$TERM" != 'dumb' ] && [ -n "$BASH" ] && [ -n "$PS1" ]
then
  SHORTHOST=`echo $HOSTNAME | sed 's/\([^\.]*\.[^\.]*\)\..*/\1/'`
  WHOAMI=`whoami`
  if [ "$WHOAMI" == "root" ]
  then
    # root gets a different color prompt
    export PS1="${LGREEN}[${YELLOW}\u${LCYAN}@${LRED}${SHORTHOST}${LGREEN}:${LPURPLE}\W${LGREEN}]${LBLUE}\\$ ${NC}"
  else
    # This is my prompt
    export PS1="${LGREEN}[${LBLUE}\u${YELLOW}@${LPURPLE}${SHORTHOST}${LGREEN}:${LCYAN}\W${LGREEN}]\$ ${NC}"
  fi
fi

# Sets up reasonable history for bash, storing times. Also creates a file
# .bash_eternal_history that permanently stores all commands from all open terminals

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth
# Add unix timestamps to history
export HISTTIMEFORMAT='%F %T '

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify

## history grep
# This allows you to search your eternal history easily.
function hgrep() {
    grep "$@"  ~/.bash_eternal_history
}

# Create ~/.bash_eternal_history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> $HOME/.bash_eternal_history'

# Print a fortune if we're in a terminal
if [ -t 1 ] ; then myfortune; fi
