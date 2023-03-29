### Added by Zinit's installer
ZINIT_DIR="$HOME/.local/share/zinit"
ZINIT_HOME="$ZINIT_DIR/zinit.git"
if [[ ! -f $ZINIT_HOME/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_DIR" && command chmod g-rwX "$ZINIT_DIR"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi


source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk
### End of Zinit's installer chunk

# Load .zsh_pre if available
zinit is-snippet for if"[[ -f $HOME/.zsh_pre ]]" $HOME/.zsh_pre

############
# DOTFILES #
############
export DOTFILES=${DOTFILES:=$HOME/.dotfiles}

#####################
# PROMPT            #
#####################
zinit lucid for \
    as"command" from"gh-r" atload'eval "$(starship init zsh)"' bpick'*unknown-linux-gnu*' \
    starship/starship \


#####################
# PROGRAMS          #
#####################

zinit lucid light-mode from"gh-r" as"command" bpick'*linux*' for \
     atload'
        eval "$(snm env zsh)"
        alias n="snm"
    ' mv'snm* -> snm' pick'snm/snm' \
        @numToStr/snm \
    atload'
        eval "$(zoxide init --no-aliases zsh)"
        alias z="__zoxide_z"
    ' mv'zoxide* -> zoxide' pick'zoxide/zoxide' \
        @ajeetdsouza/zoxide \
        @junegunn/fzf \
    mv'ripgrep* -> rg' pick'rg/rg' \
        @BurntSushi/ripgrep \
    mv'fd* -> fd' pick'fd/fd' \
        @sharkdp/fd \
    mv'bat* -> bat' pick'bat/bat' \
        @sharkdp/bat \
    mv'delta* -> delta' pick'delta/delta' \
        @dandavison/delta \
    atload'
        alias l="exa -abghHlS --git --group-directories-first"
    ' pick'bin/exa' \
        @ogham/exa \
    # mv'vivid* -> vivid' pick'vivid/vivid' atload'export LS_COLORS="$(vivid generate ayu)"' \
    #     @sharkdp/vivid \

zinit wait lucid light-mode as'command' for \
    from'gh-r' atinit'export PATH="$HOME/.yarn/bin:$PATH"' mv'yarn* -> yarn' pick"yarn/bin/yarn" bpick'*.tar.gz' \
        yarnpkg/yarn \

##########################
# OMZ Libs and Plugins   #
##########################
# make'!...' -> run make before atclone & atpull
zinit as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' \
    atpull'%atclone' pick"direnv" src"zhook.zsh" for \
        direnv/direnv

# IMPORTANT:
# Ohmyzsh plugins and libs are loaded first as some these sets some defaults which are required later on.
# Otherwise something will look messed up
# ie. some settings help zsh-autosuggestions to clear after tab completion




#####################
# PROGRAMS          #
#####################

zinit wait lucid light-mode as'command' for \
    from'gh-r' atinit'export PATH="$HOME/.yarn/bin:$PATH"' mv'yarn* -> yarn' pick"yarn/bin/yarn" bpick'ice' \
        yarnpkg/yarn \

zinit wait"1a" lucid light-mode from"gh-r" as"command" bpick'ice' for \
     atload'
        eval "$(snm env zsh)"
        alias n="snm"
    ' mv'snm* -> snm' pick'snm/snm' \
        @numToStr/snm \
    atload'
        eval "$(zoxide init --no-aliases zsh)"
        alias z="__zoxide_z"
    ' mv'zoxide* -> zoxide' pick'zoxide/zoxide' \
        @ajeetdsouza/zoxide \
        @junegunn/fzf \
    mv'ripgrep* -> rg' pick'rg/rg' \
        @BurntSushi/ripgrep \
    mv'fd* -> fd' pick'fd/fd' \
        @sharkdp/fd \
    mv'bat* -> bat' pick'bat/bat' \
        @sharkdp/bat \
    mv'delta* -> delta' pick'delta/delta' \
        @dandavison/delta \
    atload'
        unalias l
        alias l="exa -abghHlS --git --group-directories-first"
    ' pick'bin/exa' \
        @ogham/exa \
    # mv'vivid* -> vivid' pick'vivid/vivid' atload'export LS_COLORS="$(vivid generate ayu)"' \
    #     @sharkdp/vivid \

# atclone'
#         mkdir -p $HOME/.config/nvim/plugin
#         curl https://raw.githubusercontent.com/junegunn/fzf/master/plugin/fzf.vim -o $HOME/.config/nvim/plugin/fzf.vim
#     ' atpull'%atclone'

#####################
# MANUAL CONFIG     #
#####################


# Explanation:
# - Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# - History plugin is loaded early (as it has some defaults) to prevent empty history stack for other plugins
zinit lucid for \
    atinit"
        export ZSH_TMUX_FIXTERM=false
        export ZSH_TMUX_AUTOSTART=false
        export ZSH_TMUX_AUTOCONNECT=true
        export ZSH_TMUX_DEFAULT_SESSION_NAME='</>'
    " \
    OMZP::tmux \
    atinit"HIST_STAMPS=dd.mm.yyyy" \
    OMZL::history.zsh \



zinit wait lucid for \
	OMZL::clipboard.zsh \
	OMZL::compfix.zsh \
	OMZL::completion.zsh \
	OMZL::correction.zsh \
        OMZL::history.zsh \
    atload'
        alias ..="cd .."
        alias ...="cd ../.."
        alias ....="cd ../../.."
        alias .....="cd ../../../.."
        function take() {
            mkdir -p $@ && cd ${@:$#}
        }
        alias rm="rm -rf"
    ' \
	OMZL::directories.zsh \
	OMZL::git.zsh \
	OMZL::grep.zsh \
	OMZL::key-bindings.zsh \
	OMZL::spectrum.zsh \
	OMZL::termsupport.zsh \
    atload"
        alias gcd='git checkout dev'
        alias gce='git commit -a -e'
    " \
	OMZP::git \
	OMZP::docker-compose \
	as"completion" OMZP::docker/_docker \
    djui/alias-tips \
    https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh \
    https://github.com/junegunn/fzf/blob/master/shell/completion.zsh \
    hlissner/zsh-autopair \
    chriskempson/base16-shell \
    OMZP::fzf \
    ael-code/zsh-colored-man-pages\
    Kallahan23/zsh-colorls\
    laggardkernel/zsh-thefuck\



zinit wait lucid for \
    light-mode blockf atpull'zinit creinstall -q .' \
    atinit"
        zstyle ':completion:*' completer _expand _complete _ignored _approximate
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
        zstyle ':completion:*' menu select=2
        zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
        zstyle ':completion:*:descriptions' format '-- %d --'
        zstyle ':completion:*:processes' command 'ps -au$USER'
        zstyle ':completion:complete:*:options' sort false
        zstyle ':fzf-tab:complete:_zlua:*' query-string input
        zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm,cmd -w -w'
        zstyle ':fzf-tab:complete:kill:argument-rest' extra-opts --preview=$extract'ps --pid=$in[(w)1] -o cmd --no-headers -w -w' --preview-window=down:3:wrap
        zstyle ':fzf-tab:complete:cd:*' extra-opts --preview=$extract'exa -1 --color=always ${~ctxt[hpre]}$in'
    " \
        zsh-users/zsh-completions \
    light-mode atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    light-mode atinit"
        typeset -gA FAST_HIGHLIGHT;
        FAST_HIGHLIGHT[git-cmsg-len]=100;
        zpcdreplay;
    " \
        zdharma-continuum/fast-syntax-highlighting \
    reset \
    atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i \
            '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
    atpull'%atclone' pick"c.zsh" nocompile'!' \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”' \
        trapd00r/LS_COLORS

    # bindmap"^R -> ^H" atinit"
    #     zstyle :history-search-multi-word page-size 10
    #     zstyle :history-search-multi-word highlight-color fg=red,bold
    #     zstyle :plugin:history-search-multi-word reset-prompt-protect 1
    # " \
    #     zdharma-continuum/history-search-multi-word \


# 1. Load all .zsh files under zsh/.dotrc directory
# 3. Load ~/.localrc, if it exists
# 3. Load ~/.zsh_post if it exists
zinit wait'0a' lucid is-snippet for \
    $HOME/.dotrc/*.zsh \

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY
POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=false

source /home/viv/.local/share/zinit/plugins/tj---git-extras/etc/git-extras-completion.zsh
eval $(thefuck --alias)
eval "$(pdm --pep582)"
eval "$(direnv hook zsh)"

source /home/viv/.config/broot/launcher/bash/br


# Extra things that im not sure that id need but i wouldnt mind having .

zinit wait'1b' lucid light-mode from'gh-r' as'command' bpick'*linux*.tar.gz' for \
    numToStr/zenv \
    atload'alias h=xh' mv'xh* -> xh' pick'xh/xh' @ducaale/xh \
    mv'gh* -> gh' pick'gh/bin/gh' cli/cli \
    mv'hyperfine* -> hf' pick'hf/hyperfine' @sharkdp/hyperfine \
    charmbracelet/glow \

zinit wait'1c' lucid light-mode for \
    as"program" pick"$ZPFX/bin/git-*" src"etc/git-extras-completion.zsh" make"PREFIX=$ZPFX" tj/git-extras


# customize your own keybinding
bindkey "\e\e" fuck-command-line
zstyle ":prezto:runcom" zpreztorc "$HOME/.config/zsh/.zshrc"

eval AI_AC_ZSH_SETUP_PATH=/home/viv/.cache/ai/autocomplete/zsh_setup && test -f $AI_AC_ZSH_SETUP_PATH && source $AI_AC_ZSH_SETUP_PATH; # ai autocomplete setup

cat ~/.cache/wal/sequences


alias .3='cd ../../..'                       # Go back 3 directories
alias .4='cd ../../../..'                    # Go back 4 directories
alias .5='cd ../../../../..'                 # Go back 5 directories
