#######
# ZSH #
#######
plugins=(git)

for conf in "$HOME/.config/zsh/"*.zsh; do
  source "${conf}"
done
unset conf

ZSH_THEME=alex-crowbar


#############
# OH MY ZSH #
#############
export ZSH="/Users/alex.martin/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


#####
# z #
#####
. /opt/homebrew/etc/profile.d/z.sh


########
# PATH #
########

export JETBRAINS_SCRIPTS="$HOME/Documents/jetbrains_scripts"
export MYSQL_5_7="/opt.homebrew/opt/mysql@5.7/bin"
export NAND_2_TETRIS="$HOME/Learning/nand2tetris/tools"
export TMUX_SCRIPTS="$HOME/.config/tmux/scripts"
export SCRIPTS="$HOME/.config/scripts"
export PYENV="$HOME/.pyenv/bin"

# export PATH="$HOME/.local/bin:$JETBRAINS_SCRIPTS:$NAND_2_TETRIS:$MYSQL_5_7:$TMUX_SCRIPTS:$SCRIPTS:$PATH"
export PATH="$HOME/.local/bin:$PYENV:$NAND_2_TETRIS:$MYSQL_5_7:$SCRIPTS:$PATH"


##########
# PYTHON #
##########

export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

export PYTHON_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"
export CFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix sqlite)/include -I$(brew --prefix bzip2)/include"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


#######
# NVM #
#######
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion



#######
# SSH #
#######
alias cube='ssh lil_cube'
alias c9='ssh cloud9'

#######
# Vim #
#######
alias v="nvim"
alias pv="pipenv run nvim"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

. /opt/homebrew/opt/asdf/libexec/asdf.sh
