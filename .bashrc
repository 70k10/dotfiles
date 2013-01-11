# If not running interactively, don't do anything
[ $- != *i* ] && return

PS1='[\u@\h \W]\$ '
# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export MANPAGER="less"
export CHROMIUM_USER_FLAGS="--enable-seccomp-sandbox --purge-memory-button --memory-model=low"

##Aliases
[ -f /etc/arch-release ] && alias links='elinks'
[ -f /etc/arch-release ] && alias python='python2'
alias ls='ls --color=auto'
alias vi='vim'
alias cd..='cd ..'
alias grep='grep --color=auto'
alias chmox='chmod +x'
alias scpr="rsync --modify-window=1 -Phavze 'ssh -xac blowfish-cbc'"
alias calc='python -ic "from math import *; from random import *"'
alias eix='eix -SA --force-color'
alias upd='layman -S && eix-sync'
alias less='less -I --LINE-NUMBERS'
alias gethttpheaders='curl -I'
#alias windows='sudo aoss qemu-kvm -hda windowsxP.img -net nic,model=rtl8139,macaddr=12:34:56:78:90:14 -net tap -m 768 -localtime -alt-grab -usb -usbdevice tablet -soundhw es1370 &'
alias urxvt='urxvt -pe default,tabbed -vb'
#http://ruslanspivak.com/2010/06/02/urlencode-and-urldecode-from-a-command-line/ with modifications
alias urlencode='python -c "from sys import argv; from urllib import quote_plus; print quote_plus(argv[1])"'
alias urldecode='python -c "from sys import argv; from urllib import unquote_plus; print unquote_plus(argv[1])"'

##Shell options
stty -ixon		# disable XON/XOFF flow control (^s/^q)
export HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:ll:la:l.:pwd:exit:clear"
PROMPT_COMMAND='history -a'
shopt -s histappend
HISTTIMEFORMAT='%a %b %d %T  $ '
shopt -s checkwinsize
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s checkhash
shopt -s cmdhist
#shopt -s hostcomplete
# autocomplete ssh hosts
complete -W "$(echo `cut -d, -f1 ~/.ssh/known_hosts | cut -d' ' -f1 | grep -v '^$'`;)" ssh



##functions
ext () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xvjf $1		;;
			*.tar.gz)	tar xvzf $1		;;
			*.bz2)		bunzip2 $1		;;
			*.rar)		rar x $1		;;
			*.gz)		gunzip $1		;;
			*.tar)		tar xvf $1		;;
			*.tbz2)		tar xvjf $1		;;
			*.tgz)		tar xvzf $1		;;
			*.zip)		unzip $1		;;
			*.Z)		uncompress $1	;;
			*)			echo "'$1' cannot be extracted via ext()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

waitfor() { 
    while true; 
    do clear; 
    $*; 
    CAPP=`$*|grep '\*'|awk '{print $2}'|sed 's/-[0-9].*//'`; [ ! -z ${CAPP} ] && echo && eix --exact $CAPP; 
    sleep 5; 
    done 
}

cdl ()
{
	cd "$@" && ls
}

xkcd ()
{
    wget -q http://dynamic.xkcd.com/comic/random/ -O - | grep -Eo http://imgs.xkcd.com/comics/.*png | wget -q -i - -O - | display
}


# backup 
#################
bu ()
{
    if [ "`dirname $1`" == "." ]; then
        mkdir -p ~/.backup/`pwd`;
        cp $1 ~/.backup/`pwd`/$1-`date +%Y%m%d%H%M`.backup;
    else
        mkdir -p ~/.backup/`dirname $1`;
        cp $1 ~/.backup/$1-`date +%Y%m%d%H%M`.backup;
    fi
}

# define - fetch word defnition from google
# usage: define 
define ()
{
  links -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 5 -w "*"  | sed 's/;/ -/g' | cut -d- -f5 > /tmp/templookup.txt
  if [[ -s  /tmp/templookup.txt ]] ;then    
    until ! read response
      do
      echo "${response}"
      done < /tmp/templookup.txt
    else
      echo "Sorry $USER, I can't find the term \"${1} \""                
  fi    
  rm -f /tmp/templookup.txt
}

case "$-" in
*i*) clear;
     echo -e "";
     echo -ne "Today is "; date;
     echo -e ""; cal ;
     echo -ne "Up time: ";uptime | awk -F \('up'\|\,\) '{print $2}';
     echo "";
     if which fortune &> /dev/null; then fortune;fi;;
*)
esac



#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#Fix for RVM in Gentoo
[ -f /etc/gentoo-release ] && unset RUBYOPT
