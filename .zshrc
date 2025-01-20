# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"


# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:$PATH

# Path to your oh-my-zjh installation.
export ZSH="$HOME/.oh-my-zsh"

# For brew | npm packages paths
export BREW_INSTALLED="/opt/homebrew/opt"

# use this one instead of BREW_INSTALLED
export HOMEBREW_PREFIX="/opt/homebrew/opt"
PATH=$HOMEBREW_PREFIX:$PATH

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# oh-my-zsh theme
ZSH_THEME="apple"

# set Terminal env as "alacritty"
# This requires additional setups, you have to check related post
# https://unix.stackexchange.com/questions/597445/why-would-i-set-term-to-xterm-256color-when-using-alacritty
# export TERM="xterm-kitty"


# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

#oh-my-zsh
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR="nvim"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Aliases
alias ..='cd ..'
alias zshconfig='nvim ~/.zshrc'
alias mygrind='cd /Users/yh/desktop/Dev'
alias downloads='cd /Users/yh/Downloads && open .'
alias alacconfig='nvim ~/.config/alacritty/alacritty.toml'
alias nvimconfig='nvim ~/.config/nvim'
alias kittyconfig='nvim ~/.config/kitty'
alias vim='nvim'
alias newsession='tmux new-session -s mygrind'
alias jobdone='tmux kill-session -t mygrind'
alias killall='tmux kill-server'
alias srczsh='source ~/.zshrc'
alias dev='tmux new-session -s dev\; \
  send-keys 'nvim .' C-m \; \
  tmux split-window -v \; \
  tmux split-window -h \;' 
alias tx='tmuxinator'
alias tmuxconfig='nvim ~/.tmux.conf'
alias imgpr='kitten icat $(fd -e jpg -e svg -e webp -e png -e jpeg -e gif | fzf)'
alias buildflake='darwin-rebuild switch --flake "$(readlink -f ~/.config/nix)"#$HOSTNAME'


# Path for testing scripts
export PATH=/Users/yh/desktop/Dev/study-material/linux/scripts:$PATH

# nvm
export NVM_DIR="$BREW_INSTALLED/nvm"
[ -s "$BREW_INSTALLED/nvm/nvm.sh" ] && . "$BREW_INSTALLED/nvm/nvm.sh"  # This loads nvm
[ -s "$BREW_INSTALLED/nvm/etc/bash_completion" ] && . "$BREW_INSTALLED/nvm/etc/bash_completion"  # This loads nvm bash_completion

# run-help
unalias run-help
autoload run-help
autoload run−help−git
autoload run−help−ip
autoload run−help−openssl
autoload run−help−p4
autoload run−help−sudo
autoload run−help−svk
autoload run−help−svn
alias help=run-help
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"


# custom intial pwd setup
SHOULD_CHANGE=$(pwd | grep "/Users/yh/[d,D]esktop/" -c)
if [[ ${SHOULD_CHANGE} -eq 0 ]] 
then
  cd /Users/yh/desktop
fi


# zsh-syntax-highlighting
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
PATH=~/.console-ninja/.bin:$PATH

# powerlevel10k
# source /opt/homebrew/opt/powerlevel10k/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

#  Eza (better ls)
alias ls="eza --icons=always"

# zoxide (better cd)
alias cd="z"
eval "$(zoxide init zsh)"

# autojump
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh


eval $(thefuck --alias)

# bun completions
[ -s "/Users/yh/.bun/_bun" ] && source "/Users/yh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# for yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# alias
alias lg="lazygit"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
