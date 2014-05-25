#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vi='gvim'
alias killme='sudo shutdown -h now'

#PS1='[\u@\h \W]\$ '
PS1='\[\e[36m\]┌\[\e[0m\] \[\033[01;32m\]\]\u@\h\[\033[00m\]:\[\033[01;34m\]\][\w]\[\033[00m\]\] \n\[\e[36m\]└─>\[\e[0m\] '

# For python virtualenv
#export WORKON_HOME=~/.virtualenvs
export WORKON_HOME=/root/virtualenvs
source /usr/bin/virtualenvwrapper.sh

# For autocomplete when using bash
if [ "$PS1" ]; then
    complete -cf sudo
    fi

# For vi style bash prompt
set -o vi

bind -m vi-insert "\C-l":clear-screen
bind -m vi-insert "\C-u":clear-line

export PERL_LOCAL_LIB_ROOT="/home/petar/perl5";
export PERL_MB_OPT="--install_base /home/petar/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/petar/perl5";
export PERL5LIB="/home/petar/perl5/lib/perl5/x86_64-linux-thread-multi:/home/petar/perl5/lib/perl5";
export PATH="/home/petar/perl5/bin:$PATH";
export PATH="/opt/mpich/bin:$PATH";
export PATH="/opt/android-sdk/platfrom-tools:$PATH";
export PATH="/opt/android-studio/bin:$PATH";
export JAVA_HOME="/opt/java7";
