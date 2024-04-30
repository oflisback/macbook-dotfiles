# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

eval "$(brew shellenv)"

source_if_exists $HOME/.env.sh

export PATH=$HOME/node_modules/.bin:$HOME/bin:/home/linuxbrew/.linuxbrew/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH

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

alias top="htop"
alias emacs="emacs -nw"
alias ls="exa"

# Avoid problems with ^ which otherwise needs to be escaped
# alias git="noglob git"

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

# Like watch, but with color
function cwatch {
   while true; do
     CMD="$@";
     # Cache output to prevent flicker. Assigning to variable
     # also removes trailing newline.
     output=`refresh "$CMD"`;
     # Exit if ^C was pressed while command was executing or there was an error.
     exitcode=$?; [ $exitcode -ne 0 ] && exit $exitcode
     printf '%s' "$output";  # Almost the same as echo $output
     sleep 1;
   done;
}

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-prelazy="NVIM_APPNAME=OlaPreLazy nvim"
alias nvim-playground="NVIM_APPNAME=NvimPlayground nvim"
alias nvim-astro="NVIM_APPNAME=astro nvim"
alias nvim-lindell="NVIM_APPNAME=lindellAstro nvim"

function nvims() {
  items=("default" "LazyVim" "NvChad" "OlaPreLazy" "NvimPlayground astro lindellAstro")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config="OlaPreLazy"
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion




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
