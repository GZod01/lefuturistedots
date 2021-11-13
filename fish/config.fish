set PATH ~/.npm-global/bin $PATH
set PATH ~/.gem/ruby/2.7.0/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.local/bin $PATH

export DENO_INSTALL="/home/mbess/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Clipboard management
alias c='xclip -selection c'
alias p='xclip -selection c -o'

alias lsa='ls --color=never'
alias ll='ls -A -l --color=never'
alias fde='firefox-developer-edition'

# strings utils
alias upper="tr a-z A-Z"
alias lower="tr A-Z a-z"

# Kitty alias
alias icat="kitty +kitten icat --align=left"

export GTK_THEME="Adwaita:dark"
