# for now I'm disabling vi key bindings
# fish_vi_key_bindings
fish_default_key_bindings


# install zoxide
zoxide init fish | source

set PATH ~/.npm-global/bin $PATH
set PATH ~/.gem/ruby/2.7.0/bin $PATH
set PATH ~/go/bin $PATH
set PATH ~/.local/bin $PATH
set PATH /usr/lib/emscripten $PATH
set PATH /mnt/data/_content/apps/youtube-dl-music $PATH

export DENO_INSTALL="/home/mbess/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# Important alias to open any file
alias o='xdg-open'

# Allow to swallow with devour
alias sw='devour'
alias swo='devour xdg-open'

# Clipboard management
alias c='xclip -selection c'
alias p='xclip -selection c -o'

# Add random utils
alias randstr='head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20'

# Add texlive package manager
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'

# Get the file type quickly
alias mime='xdg-mime query filetype'

alias lq='ls --color=never'
alias ll='ls -A -l --color=never'
alias fde='firefox-developer-edition'

alias volume='echo "May be you want to use pulsemixer?"'
alias throttle='echo "May be you want to use pv?"'
alias pipemonit='echo "May be you want to use pv?"'
alias netmonit='echo "May be you want to use nload?"'
alias monit='echo "pv to monit pipes, nload to monit network"'

# strings utils
alias upper="tr a-z A-Z"
alias lower="tr A-Z a-z"

# Kitty alias
alias icat="kitty +kitten icat --align=left"

alias passgen="echo 'its pwgen' && pwgen -n -c -s 15 1"

export GTK_THEME="Adwaita:dark"

# alias to easily copy the first column of the first column
alias firstcell="sh ~/dots/scripts/first_cell.sh"

alias cdc="cd /mnt/data/_content"
alias cdw="cd /mnt/data/workspace"
alias cdq="cd /mnt/data/workspace/quasator"

# disable bell sound
# alias less='less -Q'
# alias man='man -P "less -Q"'
alias redislocal="redis-cli -a redispasswordverysecure"
alias cal="cal --monday"
alias py="python3"
alias py3="python3"

alias calc="qalc"
alias wttr="curl wttr.in/Aubevoye"

# git alias
#alias st="status"
#alias ci="commit"
alias "gitlg"="git log --graph --pretty=format:'%Cred%h %Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# Warn that we are using nano
alias nano="echo 'YOU ARE USING NANO?'"
# But still provide a way to access it
alias onano="/usr/bin/nano"

alias feh='echo "May be you want to use sxiv?"'
alias sxiv='nsxiv'
alias iv='nsxiv'
alias ofeh='/usr/bin/feh'

alias vim="nvim"
alias ovim="/usr/bin/vim"

# cht.sh alias
alias cheat="cht.sh"

# add auto complete for cheat sheet
# https://github.com/Dagefoerde/dotfiles/blob/fc5452bb9931f20d5702b2d5a25904da71a0c9ef/fish/own_functions/cheat.fish#L7
complete -c cheat -xa '(curl -s cheat.sh/:list)'

# related to https://github.com/alacritty/alacritty/issues/2838
alias ssh="env TERM=xterm-256color /usr/bin/ssh"

# Dot file management with git bare repository
# ref: https://www.atlassian.com/git/tutorials/dotfiles
# ref: https://gpanders.com/blog/managing-dotfiles-with-git/
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"


# Get the file type quickly
alias mime='xdg-mime query filetype'

function fish_prompt
    printf '%s%s%s@laptop %s%s%s> ' (set_color $fish_color_user) $USER (set_color normal) \
        (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
end

# Start GNOME Keyring
# see: https://wiki.archlinux.org/title/GNOME/Keyring#Using_the_keyring
if test -n "$DESKTOP_SESSION"
    set -x (gnome-keyring-daemon --start | string split "=")
end

# Start X at login after login screen (for now disabled)
#if status is-interactive
#    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
#        exec startx -- -keeptty
#    end
#end

