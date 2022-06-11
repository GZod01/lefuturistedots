set PATH ~/.npm-global/bin $PATH
set PATH ~/.gem/ruby/2.7.0/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.local/bin $PATH
set PATH /usr/lib/emscripten $PATH
set PATH /mnt/data/_content/apps/youtube-dl-music $PATH

export DENO_INSTALL="/home/mbess/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Add texlive package manager
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

# Clipboard management
alias c='xclip -selection c'
alias p='xclip -selection c -o'

alias lq='ls --color=never'
alias ll='ls -A -l --color=never'
alias fde='firefox-developer-edition'

alias volume='echo "May be you want to use pulsemixer?"'

# strings utils
alias upper="tr a-z A-Z"
alias lower="tr A-Z a-z"

# Kitty alias
alias icat="kitty +kitten icat --align=left"

alias passgen="echo 'its pwgen' && pwgen -n -c -s 15 1"

export GTK_THEME="Adwaita:dark"

alias cdc="cd /mnt/data/_content"
alias cdw="cd /mnt/data/workspace"
alias cdq="cd /mnt/data/workspace/quasator"

alias redislocal="redis-cli -a redispasswordverysecure"
alias cal="cal --monday"
alias py="python3"
alias py3="python3"

# git alias
#alias st="status"
#alias ci="commit"
alias "gitlg"="git log --graph --pretty=format:'%Cred%h %Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# Warn that we are using nano
alias nano="echo 'YOU ARE USING NANO?'"
# But still provide a way to access it
alias onano="/usr/bin/nano"

# cht.sh alias
alias cheat="cht.sh"

# add auto complete for cheat sheet
# https://github.com/Dagefoerde/dotfiles/blob/fc5452bb9931f20d5702b2d5a25904da71a0c9ef/fish/own_functions/cheat.fish#L7
complete -c cheat -xa '(curl -s cheat.sh/:list)'


function fish_prompt
    printf '%s%s%s@laptop %s%s%s> ' (set_color $fish_color_user) $USER (set_color normal) \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# Start GNOME Keyring
# see: https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring
if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

