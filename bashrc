export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/share/python:$PATH
export PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
export PATH=/usr/local/lib/node_modules:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.3-p125/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

#See:  http://www.ukuug.org/events/linux2003/papers/bash_tips/
PS1="\[\033[0;34m\][\u@\h:\w]$\[\033[0m\]"

# enable homebrew bash completion.  must install homebrew's version of
# bash completion using "brew install bash-completion" first:

#if [ -f `brew --prefix`/etc/bash_completion ]; then
#  . `brew --prefix`/etc/bash_completion
#fi

# ---------> VERY IMPORTANT: Bash eternal history <---------
#
# This incredibly important snippet allows infinite recording of
# every command you've ever entered on the machine. It works
# without using lots of memory w/ a large HISTFILESIZE *and* keeps
# track if you have multiple screens and ssh sessions into the
# same machine.
#
# The way it works is that after each command is executed and
# before a prompt is displayed, a line with the last command (and
# some metadata) is written to ~/.bash_eternal_history.
#
# This file ia tab-delimited, timestamped file, w/ the following columns:
#
# 1) user
# 2) hostname
# 3) screen window (in case you are using GNU screen, which you should!)
# 4) date
# 5) current working directory (very useful to see *where* a command was run)
# 6) the last command you executed
#
# The only minor bug: if you include a literal tab (e.g. with awk
# -F"\t"), then that messes up the formatting a bit. If you have a
# fix for that which doesn't slow the command down, please tell
# balajis@counsyl.com
#
# It is adapted from: http://www.debian-administration.org/articles/543.
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo -e $$\\t$USER\\t$HOSTNAME\\tscreen $WINDOW\\t`date +%D%t%T%t%Y%t%s`\\t$PWD"$(history 1)" >> ~/.bash_eternal_history'

# Safety
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
set -o noclobber

# Listing, directories, and motion
alias ll="ls -alrtF --color=auto"
alias la="ls -A"
alias l="ls -CF"
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias m='less'
alias ..='cd ..'
alias ...='cd ..;cd ..'
alias md='mkdir'
alias cl='clear'
alias du='du -ch --max-depth=1'
alias treeacl='tree -A -C -L 2'
alias coldiff='diff --strip-trailing-cr -W200 -wbBy'
alias less='less -R'
alias grep='grep --color=always'

# Better defaults for common commands
alias emacs='emacs -nw'
alias lessrs='less -R -S'
alias ec='emacsclient -n'

# Git abbreviations
alias gts="git status"

# grep functions
function gbeh() { grep "$@" ~/.bash_eternal_history ;}
alias python_summary='grep -E "class.*\(.*\):|def.*\(.*\):"'

# Turn on TerminalColours SIMBL package
# Colorize the Terminal
export CLICOLOR=1

# Installed MacVim through Homebrew.  These commands are required to make it work:

if [ $OSTYPE == "darwin10.0" ]; then
    alias vim='mvim -v'
    alias vi='mvim -v'
fi
