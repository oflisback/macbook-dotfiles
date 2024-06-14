alias vgrep="nvim \`grep -rl $1\`"

alias top="htop"
alias emacs="emacs -nw"
alias ls="exa"
alias pip="pip3"

alias euler="ssh -t -X euler"
alias olawiki="emacs ~/repos/notes/orgfiles/personal/journal/2024.org"
alias krucomwiki="emacs ~/repos/orgfiles/krucom/krucomwiki2.org"
alias mwiki="emacs ~/repos/orgfiles/work/modelon/modelon.org"
alias shax="cd /media/wd1/Ola/company/eget/solid\ hax\ 2013-"
alias ncpamixer="echo try super + shift + \{i,o\} instead!"
alias gpt="chatgpt-cli --settings=/home/bolland/chatgpt-api-settings.js"
# function ssh_alias() {
#   ssh "$@";
#   setterm -default -clear rest;
#  # If `-clear rest` gives error `setterm: argument error: 'rest'`, try `-clear reset` instead
#}

# alias ssh=ssh_alias
# alias task=go-task
alias rgf='rg --files | rg'

# Avoid problems with ^ which otherwise needs to be escaped
# alias git="noglob git"

alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-playground="NVIM_APPNAME=NvimPlayground nvim"
alias nvim-astro="NVIM_APPNAME=astro nvim"
alias nvim-lindell="NVIM_APPNAME=lindellAstro nvim"
alias nvim-scratch="NVIM_APPNAME=nvim nvim"
alias vim=nvim-scratch

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
