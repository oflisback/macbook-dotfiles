# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export OBSIDIAN_REST_API_KEY=$(~/.config/echo-obsidian-key.sh)

source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export PATH=$HOME/node_modules/.bin:$HOME/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/go/bin:$HOME/.cargo/bin:/opt/homebrew/bin/nvim:$PATH

source_if_exists $HOME/.env.sh
source_if_exists $HOME/.profile

eval "$(brew shellenv)"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

### End of Zinit's installer chunk

# Load OMZ Git library
zinit snippet OMZL::git.zsh

# Load Git plugin from OMZ
zinit snippet OMZP::git
zinit cdclear -q # <- forget completions provided up to this moment

setopt promptsubst

zinit snippet OMZT::gnzh

#zinit light NicoSantangelo/Alpharized
autoload colors
colors
zplugin snippet OMZ::themes/risto.zsh-theme	

PATH=~/bin:/var/lib/snapd/snap/bin:~/.local/bin:~/scripts:$PATH

# Disable scmpuff for now, learn vim-fugitive instead.
# eval "$(scmpuff init -s)"

#Avoid rm confirmation
setopt localoptions rmstarsilent

VISUAL="NVIM_APPNAME=astro nvim"
export VISUAL EDITOR="NVIM_APPNAME=astro nvim"
export EDITOR

setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history

# Vim editing
bindkey -v

bindkey '^R' history-incremental-search-backward

# Include some custom work related aliases
source ~/.zsh-aliases

# Load the git tab completion script
zstyle ':completion:*:*:git:*' script ~/.zsh/.git-completion.bash
# `compinit` scans $fpath, so do this before calling it.
fpath=(~/.zsh $fpath)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/terraform terraform

# Någon av dessa ger iaf lista vid ctrl-r sök
# Kanske ersätts av .fzf.zsh
# source /usr/share/fzf/key-bindings.zsh
# source /usr/share/fzf/completion.zsh

# source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# `refresh cmd` executes clears the terminal and prints
# the output of `cmd` in it.
function refresh {
  tput clear || exit 2; # Clear screen. Almost same as echo -en '\033[2J';
  bash -ic "$@";
}

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
zinit ice depth=1; zinit light romkatv/powerlevel10k

### End of Zinit's installer chunk

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

eval "$(zoxide init zsh)"

