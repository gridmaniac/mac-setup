export PATH="$HOME/bin:$HOME/.local/bin:/opt/homebrew/bin:/usr/local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="wezm"
zstyle ':omz:update' mode reminder
COMPLETION_WAITING_DOTS="true"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

export NVM_DIR="$HOME/.nvm"
for nvm_sh in "$NVM_DIR/nvm.sh" "/opt/homebrew/opt/nvm/nvm.sh"; do
  [ -s "$nvm_sh" ] && source "$nvm_sh" && break
done

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

eval "$(zoxide init zsh)"
alias cd='z'

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias nosleep='nohup caffeinate -is >/dev/null 2>&1 &'
alias cansleep='killall caffeinate'

command -v horse >/dev/null && alias h='eval "$(horse)"'

# Machine-specific stuff (work aliases, tokens, PATH tweaks) — not committed
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
