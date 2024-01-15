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
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh


##########
# direnv #
##########
eval "$(direnv hook zsh)"

########
# PATH #
########

export NAND_2_TETRIS="$HOME/Learning/nand2tetris/tools"
export TMUX_SCRIPTS="$HOME/.config/tmux/scripts"
export SCRIPTS="$HOME/.config/scripts"
export PYENV="$HOME/.pyenv/bin"

export PATH="$HOME/.local/bin:$PYENV:$NAND_2_TETRIS:$TMUX_SCRIPTS:$SCRIPTS:$PATH:$HOME/go/bin:$HOME/development/flutter/bin"


##########
# PYTHON #
##########

export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

if [[ "$OSTYPE" == "darwin"* ]]; then
  export PYTHON_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"
  export CFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix sqlite)/include -I$(brew --prefix bzip2)/include"
  export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib -L/opt/homebrew/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include -I/opt/homebrew/opt/llvm/include"
fi

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

alias dot="v ~/.config"
alias linux='qemu-system-aarch64 -monitor stdio -M virt,highmem=off -accel hvf -cpu host -smp 4 -m 3000 -bios QEMU_EFI.fd -device virtio-gpu-pci -display default,show-cursor=on -device qemu-xhci -device usb-kbd -device usb-tablet -drive file=/Users/a_mart/qemu/ubuntu-again.raw,format=raw,if=virtio,cache=writethrough -net nic -net user,hostfwd=tcp::2222-:22'
