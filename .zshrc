# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/joey/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# init conda
source ~/miniconda3/etc/profile.d/conda.sh

# User configuration

# Acvitate vim mode
bindkey -v




autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line                   # Opens Vim to edit current command line
bindkey '^R' history-incremental-search-backward # Perform backward search in command line history
bindkey '^S' history-incremental-search-forward  # Perform forward search in command line history
bindkey '^P' history-search-backward             # Go back/search in history (autocomplete)
bindkey '^N' history-search-forward              # Go forward/search in history (autocomplete)
bindkey '^w' backward-kill-word

precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
   VIM_PROMPT="%{$fg_bold[yellow]%} [% N ]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

export KEYTIMEOUT=1


# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER=google-chrome-stable
export DIFFPROG="nvim -d"
export TERMINFO=/usr/share/terminfo

# disable dpi scaling (for alacritty)
export WINIT_HIDPI_FACTOR=1
export TERMINAL=alacritty

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim
# fox for unavailable aliases when using sudo
alias sudo='sudo '

alias confvim="vim ~/.config/nvim/init.vim"
alias confi3="vim ~/.config/i3/config"
alias confalacritty="vim ~/.config/alacritty/alacritty.yml"
alias confzsh="vim ~/.zshrc"
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias bt='bluetoothctl'
alias pacdiff='sudo -H DIFFPROG=meld pacdiff'

function pdf-compress() {
    input=$1
    output=$2
    quality=$3
    if [ "$input" = "" ]; then
        echo "Input file missing"
        echo ""
        echo "Please use the function as follows:"
        echo ""
        echo "  pdf-compress input.pdf"
        echo ""
        echo "or"
        echo ""
        echo "  pdf-compress input.pdf output.pdf"
        return 1
    elif [ "$output" = "" ]; then
        mv $input "$input.old"
        output=$input
        input="$input.old"
    fi

    if [ "$quality" = "" ]; then
        quality="/prepress"
    fi

    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS="$quality" -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$output" "$input"
    return 0
}

function pdf-scan-and-compress() {
    while getopts ":i:r:o:m:" opt; do
      case $opt in
        i) input="$OPTARG"
        ;;
        r) resolution="$OPTARG"
        ;;
        o) output="$OPTARG"
        ;;
        m) color="$OPTARG"
        ;;
        \?) echo "Invalid option -$OPTARG" >&2
        ;;
      esac
    done

    hp-scan -s pdf -m "$color" -r "$resolution" -x jpeg --size=a4 --$input -o "$output" &&
        pdf-compress "$output" &&
        rm "$output.old"

}
