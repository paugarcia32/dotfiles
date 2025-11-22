
# zsh plugin manager settings: zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


eval "$(starship init zsh)"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit load agkozak/zsh-z
zi snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/dotenv/dotenv.plugin.zsh

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Execute tmux if it is not already running
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux a || exec tmux new -s default && exit;
fi


# Aliases
alias ls='eza --icons -a --color=always --group-directories-first'
alias cd..='cd ..'

alias gs='git status --short'
alias gd='git add'
alias gd.='git add .'
alias gc='git commit'
alias gp='git push'
alias gpn='git push --no-verify'
alias gu='git pull'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(auto)  %D%n%s%n"'
alias gb='git branch'
alias gch='git checkout'
alias gi='git init'
alias gcl='git clone'



# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/paugarcia32/dev/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/paugarcia32/dev/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/paugarcia32/dev/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/paugarcia32/dev/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/paugarcia32/.dart-cli-completion/zsh-config.zsh ]] && . /Users/paugarcia32/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Load MAAT config
if [ -f "${HOME}/.zshrc.MAAT" ]; then
  source "${HOME}/.zshrc.MAAT"
fi


# Github ssh

export SSH_AUTH_SOCK=/Users/paugarcia32/.bitwarden-ssh-agent.sock



ip() {
  ip=$(ipconfig getifaddr en0 || ipconfig getifaddr en1)
  if [ -z "$ip" ]; then
    echo "❌ No se pudo detectar la IP local."
  else
    echo "📡 Your local IP is: $ip"
    echo -n "$ip" | pbcopy
  fi
}


# Android SDK
export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"

# Vey Good CLI
export PATH="$PATH":"$HOME/.pub-cache/bin"
