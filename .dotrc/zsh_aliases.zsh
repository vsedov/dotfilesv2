eval "$(zoxide init zsh)"
alias water="waterfox-g4 --sync"
alias flakeupgrade="pip install flake8-annotations flake8-broken-line flake8-bugbear flake8-comprehensions flake8-debugger flake8-eradicate flake8-functions flake8-return flake8-type-checking flake8_isort flake8_match flake8_pydantic_skip flake8_quotes flake8_simplify mccabe naming pyflakes icecream rich pyinspect jedi-language-server --upgrade"
alias dcat="kitty +kitten diff"
alias icat="kitty +kitten icat"
if [[ "$TERM" == "xterm-kitty" ]]; then
  alias ssh="kitty +kitten ssh"
fi
alias pyB="echo layout pipenv >> .envrc"
alias pac="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias gss="git status"
alias gl="git log"
alias pa="php artisan"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

alias yeet="paru -Rcs"
alias yay="paru "
alias yayay="paru -S (paru -Slq | fzf -m)"
alias Yay="topgrade -y"

alias nvimconfig="cd ~/.config/nvim/"
alias nvimshare="cd ~/.local/share/nvim"

alias ve='pyvenv create '
alias vl='pyvenv list'
alias va='pyvenv shell '
alias vr='pyvenv remove '

alias vd='deactivate'
alias vrc='pip install requests'

alias trash='mv --force -t ~/.local/share/Trash '
alias senko='sudo'
alias nya='nvim'
alias neko='cat'
alias now='shutdown -h now'
alias moe='more'
alias zawarudo='git reset --soft HEAD~1'
alias startup='nvim --startuptime xd && nvim xd'
alias startupS='nvim -nu  NORC --startuptime xd && nvim xd'
alias github='cd ~/GitHub'

alias v=nvim
alias vim=nvim
alias sysinfo="inxi -Fxxxz"
# alias cat=bat
alias open=xdg-open
# Docker
alias docker.cleancontainer="docker ps -a -q | xargs docker rm"
alias docker.cleanimage="docker images --filter dangling=true -q | xargs docker rmi"

# Find & Delete all ".DS_Store" files (recursive)
alias delete.ds="find . -name '.DS_Store' -type f -print -delete"

alias mpvA='mpv --vo=gpu --profile=4x_upscaling'
alias mpva='mpv --vo=gpu --profile=upscale-anime4k'


# kitty-specific
alias kicat='kitty +kitten icat'


# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

#wget
function wget_archive_and_extract() {
  if [[ -z "$1" ]]; then
    echo "Usage: wget_archive_and_extract <url>"
  else
    local -r URL="$1"
    local -r FILENAME="${URL##*/}"
    wget "$URL" -O "$FILENAME"
    extract "$FILENAME"
    rm "$FILENAME"
  fi
}
alias wgetae="wget_archive_and_extract "

if command -v pamac >/dev/null 2>&1; then
    alias checkup="sudo pamac checkupdates -a"
    alias up="pamac upgrade -a --no-confirm"
    alias buildup="pamac build --no-confirm"
fi

if command -v pacman >/dev/null 2>&1; then
    alias upnup="sudo pacman -Syyuu"
    alias cleanup='sudo pacman -Rsn $(pacman -Qdtq)'
fi

if command -v microk8s >/dev/null 2>&1; then
    alias k="microk8s.kubectl"
    alias kube="microk8s.kubectl"
    alias kubectl="microk8s.kubectl"
fi

# Github CLI aliases
prcreate() {
    if [ -z "$2" ]; then
        # If title is not provided then use autofill
        gh pr create -B "$1" -f
    else
        # Otherwise use provided title
        gh pr create -B "$1" -t "$2"
    fi
}

prmerge() {
    gh pr merge --merge --delete-branch=false "$1"
}
prlist() {
    gh pr list --state open
}
prcheck() {
    gh pr checkout "$1" && gh pr diff
}

# IP aliases
ip-internal() {
    echo "Wireless :: IP => $( ip -4 -o a show wlo1 | awk '{ print $4 }' )"
}
ip-external() {
    echo "External :: IP => $( curl --silent https://ifconfig.me )"
}
ipinfo() {
    ip-internal && ip-external
}

alias myip=ip-internal

open_with_fzf() {
    fd -t f -H -I | fzf -m --preview="xdg-mime query default {}" | xargs -ro -d "\n" xdg-open 2>&-
}
cd_with_fzf() {
    cd $HOME && cd "$(fd -t d | fzf --preview="tree -L 1 {}" --bind="space:toggle-preview" --preview-window=:hidden)"
}
pacs() {
    sudo pacman -Syy $(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
}
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m --ansi --color fg:-1,bg:-1,hl:46,fg+:40,bg+:233,hl+:46 --color prompt:166,border:46 --height 40%  --border=sharp --prompt="➤  " --pointer="➤ " --marker="➤ " | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}
select_file() {
    given_file="$1"
    #fd --type file --follow --hidden --exclude .git | fzf --query="$given_file"
    fzf --query="$given_file"
}

function neovim_remote {
  nvim --server $NVIM_LISTEN_ADDRESS --remote $(realpath "$@")
  # $(realpath ${1:-.})
}

use_bob() {
    bob use nightly
    file_check() {
        if [ -f "$1" ]; then
            return 0
        else
            return 1
        fi
    }
    file_check "/home/viv/.local/share/neovim/bin/nvim"
    if [ $? -eq 0 ]; then
        mv /home/viv/.local/share/neovim/bin/nvim  /home/viv/.local/share/neovim/bin/bvim
    fi
    alias nvim="bvim"
    alias vim="bvim"
    alias vi="bvim"
}

use_nvim() {
    #  remove alias of bvim
    unalias nvim
    unalias vim
    unalias vi
}

# alias juliapro=/Applications/JuliaPro-1.0.1.1.app/Contents/Resources/julia/Contents/Resources/julia/bin/julia
# alias julia=/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia
alias licdes="licmae | grep -A 3 DESMOND_GPGPU"
# alias spritz="~/Desktop/tommy/nsfw/spritz.py"
alias fz="cd \$(z | awk '{print \$2}' | fzf)"
alias tflip='echo "(╯°□°)╯︵ ┻━┻"'
alias clock='tty-clock -c -f %d-%m-%Y'
alias pudb='python -m pudb'
alias ptpy='ptipython --vi'
alias vxl='/opt/VirtualGL/bin/vglconnect -s xlenceVPN'
alias mdclean='rm -ri *_trj *out* *cpt* *log *.ene *checkpoint* *-in.cms'
alias nvr=neovim_remote
alias nvrs="nvim --server $NVIM_LISTEN_ADDRESS --remote-send"
alias nvre="nvim --server $NVIM_LISTEN_ADDRESS --remote-expr"


alias tclsh="rlwrap -Ar -pcyan tclsh"
alias lua="rlwrap -Ar -pcyan --always-readline lua"
alias luajit="rlwrap -Ar -pcyan --always-readline luajit"
alias thist="tmux capture-pane -epS - > /tmp/tmuxhist && vim -c 'te cat /tmp/tmuxhist' -c stopinsert"
alias kk="ps -ef | fzf | awk '{print $2}' | xargs kill -9 "


alias gpp="git push personal"
alias luamake=/home/viv/GitHub/lua-language-server/3rd/luamake/luamake
alias water-fox="waterfox --sync"

# fzf版cdd
alias cdd='_fzf-cdr'
_fzf-cdr() {
  local target_dir=$(cdr -l  \
    | sed 's/^[^ ][^ ]*  *//' \
    | fzf-tmux -p80% --bind 'ctrl-t:execute-silent(echo {} | sed "s/~/\/Users\/$(whoami)/g" | xargs -I{} tmux split-window -h -c {})+abort' \
        --preview "echo {} | sed 's/~/\/Users\/$(whoami)/g' | xargs -I{} ls -l {} | head -n100" \
    )
  # ~だと移動できないため、/Users/hogeの形にする
  target_dir=$(echo ${target_dir/\~/$HOME} | tr -d '\')
  if [ -n "$target_dir" ]; then
    cd $target_dir
  fi
}

# カレントディレクトリ以下をプレビューし選択して開く
alias lk='_look'
_look() {
  if [ "$1" = "-a" ]; then
    local find_result=$(find . -type f -o -type l)
  else
    local find_result=$(find . -maxdepth 1 -type f -o -type l)
  fi
  local target_files=($(echo "$find_result" \
    | sed 's/\.\///g' \
    | grep -v -e '.jpg' -e '.gif' -e '.png' -e '.jpeg' \
    | sort -r \
    | fzf-tmux -p80% --select-1 --prompt 'vim ' --preview 'bat --color always {}' --preview-window=right:70%
  ))
  [ "$target_files" = "" ] && return
  vim -p ${target_files[@]}
}

E() {
    IFS=$'\n' files=("$(fzf-tmux --query="$1" --multi --select-1 --exit-0)")
    [[ -n "$files" ]] && "${EDITOR:-vim}" "${files[@]}"
}

tn() {
    session_name=${PWD##*/}
    config=${TMUX_CONFIG}
    tmux -f "$config" new-session -s "$session_name"
}

create_workstation() {
    name=$1
    directory=$2
    tmux -f "$TMUX_CONFIG" new-session -d -s "$name" -c "$directory"
    tmux list-sessions
    tmux new-window -t "$name" -c "$directory"
    tmux send-keys -t "$name":0 "e" Enter
}
create_or_attach_work_session() {
    name=$1
    directory=$2
    if [[ -n $TMUX ]]; then
        if (tmux has-session -t "$name"); then
            tmux -f "$TMUX_CONFIG" switch -t "$name"
        else
            create_workstation "$name" "$directory"
            tmux -f "$TMUX_CONFIG" switch -t "$name":0
        fi
    else
        if (tmux has-session -t "$name"); then
            tmux -f "$TMUX_CONFIG" attach -t "$name"
        else
            create_workstation "$name" "$directory"
            tmux -f "$TMUX_CONFIG" attach -t "$name":0
        fi
    fi
}
alias cdd='_fzf-cdr'
_fzf-cdr() {
  local target_dir=$(cdr -l  \
    | sed 's/^[^ ][^ ]*  *//' \
    | fzf-tmux -p80% --bind 'ctrl-t:execute-silent(echo {} | sed "s/~/\/Users\/$(whoami)/g" | xargs -I{} tmux split-window -h -c {})+abort' \
        --preview "echo {} | sed 's/~/\/Users\/$(whoami)/g' | xargs -I{} ls -l {} | head -n100" \
    )
  # ~だと移動できないため、/Users/hogeの形にする
  target_dir=$(echo ${target_dir/\~/$HOME} | tr -d '\')
  if [ -n "$target_dir" ]; then
    cd $target_dir
  fi
}
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fgg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z



alias ls=colorls
alias kc=kitty --listen-on unix:/tmp/kitty
alias ranger='TERM=xterm-kitty ranger'
alias rickroll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias df='duf'
alias free='free -h'
alias telnet='telnet -e p'
alias grep='grep --color=auto'                    # show differences in color
alias egrep='egrep --color=auto'                  # show differences in color
alias fgrep='fgrep --color=auto'                  # show differences in color


# get top process eating cpu and memory
alias psa="ps auxf"                                        # show all processes
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"   # show all processes eating memory
alias psmem='ps auxf | sort -nr -k 4'                      # show all processes eating memory
alias psmem10='ps auxf | sort -nr -k 4 | head -10'         # show top 10 processes eating memory
alias pscpu='ps auxf | sort -nr -k 3'                      # show all processes eating cpu
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'         # show top 10 processes eating cpu




# Networking
alias netCons='lsof -i'                                                             # netCons:      Show all open TCP/IP sockets
alias lsock='sudo /usr/sbin/lsof -i -P'                                             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'                                   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'                                   # lsockT:       Display only open TCP sockets
alias ipInfo0='ifconfig getpacket en0'                                              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ifconfig getpacket en1'                                              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'                                        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                                                  # showBlocked:  All ipfw rules inc/ blocked IPs
alias publicip='echo "Current Public IP address is:" && curl ifconfig.me && echo'   # publicip:     Get Public IP address


# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"                                                    # jctl:         Show errors from journalctl

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"                              # gpg-check:    Verify a signature
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"                     # gpg-retrieve: Retrieve a key


# ani-cli
# Get this script from Github: https://github.com/pystardust/ani-cli or AUR
alias ani='ani-cli'                                                                 # ani:          Ani-cli
alias anid='ani-cli -d'                                                             # anid:         Download anime
alias anih='ani-cli -H'                                                             # anih:         Resume watching anime
alias anib='ani-cli -q "best"'                                                      # anib:         Watch anime with best quality
alias aniw='ani-cli -q "worst"'                                                     # aniw:         Watch anime with worst quality
alias anidb='ani-cli -d -q "best"'                                                  # anidb:        Download best quality
alias anidw='ani-cli -d -q "worst"'                                                 # anidw:        Download worst quality


### ARCHIVE EXTRACTION
## This function needs several packages, like tar, unzip, p7zip, etc.
# usage: ex <file>
ex ()
{
  if [ -f "$1" ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

### File transfer using transfer.sh
# Add this to .bashrc or .zshrc or its equivalent
# usage: transfer test.txt
transfer() {
    if [ $# -eq 0 ]; then
        echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>" >&2
        return 1
    fi
    if tty -s; then
        file="$1"
        file_name=$(basename "$file")
        if [ ! -e "$file" ]; then
            echo "$file: No such file or directory" >&2
            return 1
        fi
        if [ -d "$file" ]; then
            file_name="$file_name.zip" ,
            (cd "$file" && zip -r -q - .) | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null,
        else cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null; fi
    else
        file_name=$1
        curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name" | tee /dev/null
    fi
}
