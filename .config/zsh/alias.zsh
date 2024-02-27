#######################
# General zsh aliases #
#######################

#######
# GIT #
#######
alias gs='git status'
alias gc='git checkout'
alias gcm='git checkout main'
alias gpo='git push origin '
alias glo='git pull origin '
alias glom='git pull origin main'
alias gaa='git add --all'
alias gb='git checkout -b '
alias gcom='git commit -m '
alias gd='git branch -d '


#######
# ZSH #
#######
alias cz='cat ~/.zshrc'
alias vz='nvim ~/.zshrc'

#########
# SHELL #
#########
alias cl='clear'
alias wipe='rm -rf'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

########
# TMUX #
########
alias t='tmux'
alias ta='tmux attach-session -t '
alias tl='tmux ls'
alias tk='tmux kill-session -t '
alias tn='tmux new-session -s '

#######
# K8s #
#######
alias k='kubectl'
alias dr='docker run'
alias ds='docker start'
alias ipy='ipython'

########
# SYNE #
########
alias syne1='ssh syne@192.168.6.230'
alias syne2='ssh syne@192.168.7.78'
alias syne3='ssh syne@192.168.7.97'
alias dynamo='java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb'
alias sso="aws sso login"

###########
# journal #
###########
alias journal='cd ~/Documents/journal && vim "$(date +%Y-%m-%d).txt"'

