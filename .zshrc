# -*- zshrc -*-
# Michal Suszko
# $Id: .zshrc,v 1.4 2005/04/08 12:40:19 dry Exp dry $
#
# Environment variables

case `uname` in
'SunOS')
    PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/ccs/bin:/usr/ucb:/usr/local/bin:/usr/local/sbin
    MANPATH=/usr/share/man:/usr/local/man:/usr/local/share/man:/usr/sfw/share/man:/usr/sfw/esp/man:/usr/perl5/5.6.1/man:/usr/openwin/share/man:/usr/dt/share/man:/usr/j2se/man:/usr/java1.2/man
    TERM=xtermc
    alias screen='TERM=screen screen'
    SCREENDIR=$HOME/.screen
    export PATH MANPATH TERM SCREENDIR
    ;;
'HP-UX')
    TERM=xtermc
    export TERM
    ;;
'Linux')
    #unalias ls
    alias ls='ls -F'
    ;;
'FreeBSD')
    ;;
*)
    ;;
esac

HISTFILE=${HOME}/.zsh_history
HISTSIZE=25000
SAVEHIST=25000
DIRSTACKSIZE=10

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt AUTO_PUSHD
setopt RMSTARSILENT
setopt NOBEEP
setopt AUTOCD


b_esc=`print -Pn "\e]0;"`
e_esc=`print -Pn "\a"`

case "${TERM}" in
screen)
    export PROMPT="%{${b_esc}$WINDOW %n@%m:%/${e_esc}%}%# "
    preexec () {
        print -Pn "\e]0;$WINDOW %n@%m:%/: ";
        print -RPn "%60>...>${(V)1//\%/%%}";
        print -Pn "\a";
    }
    ;;
xterm*|rxvt*)
    export PROMPT="%{${b_esc}%n@%m:%/${e_esc}%}%# "
    preexec () {
        print -Pn "\e]0;%n@%m:%/: ";
        print -RPn "%60>...>${(V)1//\%/%%}";
        print -Pn "\a";
    }
    ;;
*)
   export PROMPT="%m%# "
   ;;
esac

export EDITOR='vim'
export LC_ALL="pl_PL.UTF-8"
export LANG="pl_PL.UTF-8"
export RPROMPT="%~"
export MAILDIR=${HOME}/Mail/inbox/
export MAIL=$MAILDIR
export LESSCHARSET=utf-8
export PAGER=less

bindkey -e
bindkey "^U" vi-kill-line

export PATH=$HOME/env/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/local/bin:$PATH

setopt AUTOLIST

# Completion
autoload -Uz compinit
compinit

# Aliases

alias lsd='ls -d *(-/DN)'
alias ag="ag --color-line-number '1;14' --color-path '1;34' --color-match '2;31'"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C terraform terraform
