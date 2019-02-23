#!/bin/zsh

echo .zshrc

# Antigen: https://github.com/zsh-users/antigen
ANTIGEN="$HOME/.local/bin/antigen.zsh"


# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE"
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE"
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi


# Initialize command prompt
export PS1="%n@%m:%~%# "

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"


# Load local bash/zsh compatible settings
_INIT_SH_NOFUN=1
[ -f "$HOME/.local/etc/init.sh" ] && source "$HOME/.local/etc/init.sh"

# exit for non-interactive shell
[[ $- != *i* ]] && return

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE


# Initialize antigen
source "$ANTIGEN"


# Initialize oh-my-zsh
antigen use oh-my-zsh

antigen theme agnoster  # agnoster # ys # 换主题，更多主题见：https://github.com/robbyrussell/oh-my-zsh/wiki/themes
antigen bundle autojump # 自动跳转

# default bundles
# visit https://github.com/unixorn/awesome-zsh-plugins
# antigen bundle git
# antigen bundle heroku
antigen bundle pip
antigen bundle svn-fast-info
# antigen bundle command-not-find

antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle rupa/z z.sh
# antigen bundle z

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle supercrabtree/k
antigen bundle Vifon/deer

antigen bundle willghatch/zsh-cdr
# antigen bundle zsh-users/zaw

# uncomment the line below to enable theme
# antigen theme fishy


# check login shell
if [[ -o login ]]; then
    [ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
    [ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none


echo .zshrc 8

# load local config
[ -f "$HOME/.local/etc/config.zsh" ] && source "$HOME/.local/etc/config.zsh"
[ -f "$HOME/.local/etc/local.zsh" ] && source "$HOME/.local/etc/local.zsh"

echo .zshrc 9

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

echo .zshrc 12

antigen apply

echo .zshrc 11

# setup for deer
autoload -U deer
zle -N deer

echo .zshrc 10

# default keymap
bindkey -s '\ee' 'vim\n'
bindkey '\eh' backward-char
bindkey '\el' forward-char
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
# bindkey '\eu' undo
bindkey '\eH' backward-word
bindkey '\eL' forward-word
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line

bindkey '\ev' deer

echo .zshrc 1


# options
unsetopt correct_all

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Don't execute immediately upon history expansion.


# source function.sh if it exists
[ -f "$HOME/.local/etc/function.sh" ] && . "$HOME/.local/etc/function.sh"

# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
zstyle ':completion:*:*sh:*:' tag-order files

echo .zshrc 2

# ------------- 配色 -------------
# 终端使用 Coreutils 配色方案
# 采用Coreutils的gdircolor配色，修改~/.dir_colors(自定义配色)
# 以修改ls命令使用的环境变量LS_COLORS（BSD是LSCOLORS）
# 效果：不同类型的文件有不同颜色，如图水红色，文件夹群青色...

if [ -x "$(command -v brew)" ] ; then
    if brew list | grep coreutils > /dev/null ; then
        # 在mac系统下安装了brew，并安装了coreutils，本句判断才为true
        PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
        # eval '`dircolors`'
        # export CLICOLOR=1
        # between quotation marks is the tool output for LS_COLORS
        alias ls='ls -F --show-control-chars --color=auto'
        # alias ls='ls --color=auto'
        # alias ls='ls -FG'
         # --show-control-chars --color=auto'
        eval `gdircolors -b $HOME/.dir_colors`

    fi
fi

export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36::ow=1;34;7:"

# export LS_COLORS="di=31;41:ln=31;41:so=31;41:pi=31;41:ex=31;41:bd=31;41:cd=31;41:su=31;41:sg=31;41:tw=31;41:ow=31;41:"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

echo .zshrc 6
# echo "$(command -v brew)"
# if [ -x "$(command -v brew)" ] ; then echo .zshrc 7; fi

echo .zshrc 5

# 将777权限的文件在ls时，显示为文灰底紫
LS_COLORS=`echo $LS_COLORS | sed -E 's/ow=[0-9;]+://g'`:'ow=1;34;7:' ; export LS_COLORS

echo .zshrc 4

# grep 上色
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

# 使得zsh的补全配色与ls一致
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 没有找到文件（夹），仍然继续执行
# 如 rm -rf 一个文件夹/{*,.*}
# 即使没有 .* 文件，也会把 * 文件删了
setopt no_nomatch

echo .zshrc 3

# ctrl+u: 删除光标左侧
bindkey \^U backward-kill-line
# kill-whole-line  # 删除整行

# 解绑 ctrl+s ctrl+q
stty start undef
stty stop undef
setopt noflowcontrol



# if [[ -n "$TMUX" ]]; then
#     bindkey "^[[1~" beginning-of-line
#     bindkey "^[[4~" end-of-line
# fi

# bindkey '^[[H' beginning-of-line # iterm
# bindkey '^[[F' end-of-line # iterm

# ------------- 其他 -------------
# iterm2_shell_integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"



echo end .zshrc

# if [[ -o interactive ]]; then
if [[ $- == *i* ]]; then
    # 交互模式
    [ -f ~/.bash_aliases ] && . ~/.bash_aliases
fi
