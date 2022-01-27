export ZSH=$HOME/.oh-my-zsh
export HISTSIZE=30000

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
set_title () echo -ne "\033]0;$*\a"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

function expand_alias {
    if [[ ${aliases[$1]+x} ]]; then echo ${aliases[$1]}
    else echo $1; fi
}

#Convenience aliases
alias cal="urxvt -title calendar -e calcurse"
alias copy='xclip -sel clip'
alias histogram="(tr ' ' '\n' | sort | uniq -c) <"
alias kz='kill -KILL ${${(v)jobstates##*:*:}%=*}' # kill zombies
alias ls="ls -hAG --color=auto"
alias tree="tree -aCphF -L 5 -I \".git\""
svndiff () {svn diff $* | wdiff -nd | colordiff}
view_graph () {dot -Tpng -O $1 && open $1.png}

# fuzzy-find: `ff cmd [flags] arg` applies `cmd [flags]` to a file named `arg` in the current tree
# N.B. ignores directories beginning with '_' or '.' to avoid searching into e.g. `./_build` or `./.git`  
function ff () {
    `expand_alias $1` "${@[2,-2]}" `find . \( -path ./_\* -o -path ./.\* \) -prune -false -o -name "${@[-1]}"`
}

# emacs wrapper:
# (1) start server if not already running,
# (2) kill any running `emacsclient`
# (3) start a new `emacsclient` with the given args
export EMACS_BINARY=/usr/bin/emacs
function emacs () {
    if ! pgrep -xf "${EMACS_BINARY} --daemon" >/dev/null; then ${EMACS_BINARY} --daemon; fi;
    if pgrep "emacsclient" >/dev/null; then pkill -9 emacsclient; fi;
    TERM=screen-256color emacsclient -q "$@"
}
export EDITOR="TERM=screen-256color emacsclient -q"
export BROWSER="firefox"
alias fe="ff emacs"
alias e="emacs"

alias pip=pip3
alias python=python3

# PROMPTS
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd () {
    zstyle ':vcs_info:*' formats "%{$fg_bold[red]%}:%{$fg_bold[yellow]%}%b%%{$reset_color%}"
    vcs_info
}
setopt prompt_subst

#PROMPT='%{$fg_bold[red]%}%* %{$fg_bold[cyan]%}%~%{$fg_bold[yellow]%}${vcs_info_msg_0_} %{$fg_bold[red]%}λ%{$reset_color%} %}'
PROMPT='%{$fg_bold[red]%}[ %{$fg[white]%}%T %{$fg[cyan]%}%~%{$fg[yellow]%}${vcs_info_msg_0_} %{$fg_bold[red]%}]%{$reset_color%} %}'
#SETTINGS
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt IGNORE_EOF
autoload -Uz compinit && compinit -D # git autocompletion
source  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# OPAM configuration
. /home/benno/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam env)

# TeX Setup
export PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
export MANPATH="/usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH"

#Manjaro/i3 tweaks
xset -b # disable bell
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "^H" backward-kill-word

PATH="/home/benno/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/benno/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/benno/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/benno/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/benno/perl5"; export PERL_MM_OPT;


## Framework Laptop Stuff
# touchpad two-finger right-click / three-finger middle-click
#xinput set-prop "PIXA3854:00 093A:0274 Touchpad" "libinput Click Method Enabled" 0 1
