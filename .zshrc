# Path to your oh-my-zsh installation.
export ZSH=/Users/benno/.oh-my-zsh
export HISTSIZE=30000

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"
set_title () echo -ne "\e]1;$*\a"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration
source $ZSH/oh-my-zsh.sh

function expand_alias {
    if [[ ${aliases[$1]+x} ]]; then echo ${aliases[$1]}
    else echo $1; fi
}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

#Convenience aliases
alias ls="ls -hAG"
alias diff="colordiff"
alias tree="tree -aCphF -L 5 -I \".git\""
alias histogram="(tr ' ' '\n' | sort | uniq -c) <"
alias copy="pbcopy"
alias fnp="find \$(pwd) -name"
alias kz='kill -KILL ${${(v)jobstates##*:*:}%=*}' # kill zombies
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
export EMACS_BINARY=/usr/local/bin/emacs
function emacs () {
    if ! pgrep -xf "${EMACS_BINARY} --daemon" >/dev/null; then ${EMACS_BINARY} --daemon; fi;
    if pgrep "emacsclient" >/dev/null; then pkill emacsclient; fi;
    TERM=screen-256color emacsclient -q "$@"
}
export EDITOR="emacs"
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
source  /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#export DYLD_LIBRARY_PATH="/Users/BennoStein/Documents/CU/tajs_thresher	/lib"

# OPAM configuration
. /home/benno/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam env)

# PySMT configuration
#export PYTHONPATH="/home/benno/.smt_solvers/python-bindings-2.7:${PYTHONPATH}"

#Brew Setup
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="/usr/local/sbin:${HOME}/bin:${HOME}/.cargo/bin:${HOME}/.cabal/bin:${HOME}/.ghcup/bin:$PATH"
source ${HOME}/.ghcup/env

#Java Setup
export JDK_18=$(/usr/libexec/java_home -v 1.8)
#export JDK_17=$(/usr/libexec/java_home -v 1.7)
#export JDK_16=$(/usr/libexec/java_home -v 1.6)
export JAVA_HOME=$JDK_18

# Checker Framework Setup
#export CHECKERFRAMEWORK=${HOME}/jsr308/checker-framework-2.1.11
#export PATH=${CHECKERFRAMEWORK}/checker/bin:${PATH}

# TeX Setup
export PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"
export MANPATH="/usr/local/texlive/2021/texmf-dist/doc/man:$MANPATH"
export INFOPATH="/usr/local/texlive/2021/texmf-dist/doc/info:$INFOPATH"
