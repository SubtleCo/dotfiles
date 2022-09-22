# Path to your oh-my-zsh installation.
export ZSH="/Users/alex.martin/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"


plugins=(git)

source $ZSH/oh-my-zsh.sh

mg () {
    mkdir -p "$1" && cd $_
}

alias gs='git status'
alias gc='git checkout'
alias gcm='git checkout main'
alias hs='serve -l 8080'
alias welcome='./welcome'
alias gpo='git push origin '
alias glo='git pull origin '
alias glom='git pull origin main'
alias gaa='git add --all'
alias gb='git checkout -b '
alias gcom='git commit -m '
alias gd='git branch -d '
alias jserve='json-server -w $1 -p 8088'
alias z='pmset displaysleepnow'
alias cl='clear'
alias pm='python3 manage.py'
alias pms='python3 manage.py runserver'
alias p3='python3'
alias brave='BROWSER="Brave Browser.app" npm start'
alias wipe='rm -rf'


# Reset current docker compose containers, migrate to database
redock () {
    docker compose down --volumes
    make start
    sleep 5
    make migrations/migrate
}

# Change the remote repository URL. This is useful when you
# clone an instructors, or one of NSS's boilerate, repositories
# and want to then have the code on your account and you don't
# want to fork.
#
#    changeorigin git@github.com:githubhandle/reponame.git
changeorigin () {
    git remote remove origin
    git remote add origin $1
}

help () {
    clear
    echo "gohome                    Takes me to my home directory"
    echo "cat [filename]            Outputs the contents of a file right in the terminal"
    echo "touch [filename]          Creates a new file"
    echo "mkdir [directory]         Creates a new directory"
    echo "mg [directory]            Creates a new directory and goes into it"
    echo "git add --all             Stages all modified files to be committed"
    echo "gaa                       Stages all modified files to be committed"
    echo "git commit -m [message]   Commits all staged files"
    echo "gcom [message]            Commits all staged files"
    echo "gcm                       Git Checkout Main"
    echo "git push origin [branch]  Uploads your branch to Github"
    echo "gpo [branch]              Uploads your branch to Github"
    echo "glo [branch]              Git Pull Origin [branch]"
    echo "glom                      Git Pull Origin Main"
    echo "gb [branch]               Git Checkout -b (make a new branch"
    echo "changeorigin              Changes where you push your code"
}


# export PYENV_ROOT="$HOME/.pyenv/shims"
# export PATH="$PYENV_ROOT/bin:$PATH"
# export PIPENV_PYTHON="$PYENV_ROOT/python"
export SHELL_SCRIPTS_PATH="$HOME/Documents/jetbrains_scripts"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$SHELL_SCRIPTS_PATH:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

export PYTHON_CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl)"
export CFLAGS="-I$(brew --prefix zlib)/include -I$(brew --prefix sqlite)/include -I$(brew --prefix bzip2)/include"
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include"
export DYLD_FALLBACK_LIBRARY_PATH="$HOME/lib:/usr/local/lib:/usr/lib:/opt/homebrew/lib"

# /opt/homebrew/opt/cairo/lib

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Check python version
echo "currently running"
python --version
source ~/.iterm2_shell_integration.zsh

alias py='python'
alias brow='arch --x86_64 /usr/local/Homebrew/bin/brew'
alias rc='charm ~/.zshrc'

function in () {
    cd $1
    ls
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
eval
            fuck () {
                TF_PYTHONIOENCODING=$PYTHONIOENCODING;
                export TF_SHELL=zsh;
                export TF_ALIAS=fuck;
                TF_SHELL_ALIASES=$(alias);
                export TF_SHELL_ALIASES;
                TF_HISTORY="$(fc -ln -10)";
                export TF_HISTORY;
                export PYTHONIOENCODING=utf-8;
                TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER $@
                ) && eval $TF_CMD;
                unset TF_HISTORY;
                export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
                test -n "$TF_CMD" && print -s $TF_CMD
            }

alias ecrlogin='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 833816692833.dkr.ecr.us-east-1.amazonaws.com'
alias docks='docker ps --format "table {{.Names}}\t{{.Command}}\t{{.Status}}"'
alias title_db='docker exec -it title_db mysql --port=3306 --user=root --password=test --host=title_db --database=title'
alias nuke_local_title='mysql --user=root --password=mysqlpassword --execute="DROP DATABASE IF EXISTS title; CREATE DATABASE title;"'
alias nuke_local_inspections='mysql --user=root --password=mysqlpassword --execute="DROP DATABASE IF EXISTS local_inspections_service; CREATE DATABASE local_inspections_service;"'
alias guide='cat ~/Documents/guiding_principles.txt'
alias gmd='git merge develop'

# AWS login stuff
function dev () {
    awslogin aws-developer
    cp ~/.aws/aws-developer ~/.aws/credentials
}

function integ () {
    awslogin prod-integrations
    cp ~/.aws/prod-integrations ~/.aws/credentials
}

# AWS RDS credentials
alias prod_db='awslogin -db=prod-cla-soa-us-east-1 prod-support'
alias ops_db='awslogin -db=ops-cla-soa-us-east-1 aws-developer'
alias dev_db='awslogin -db=dev-cla-soa-us-east-1 aws-developer'

# AWS RDS MySQL Login
alias prod_login='awslogin -db-login=prod-cla-soa-us-east-1 prod-support'
alias ops_login='awslogin -db-login=ops-cla-soa-us-east-1 aws-developer'
alias dev_login='awslogin -db-login=dev-cla-soa-us-east-1 aws-developer'

# AWS RDS MySQL Dumps
function dump_ops () {
    database=$1
    password=$2
    mysqldump $database \
     --result-file=/Users/alex.martin/BuiltSource/dump.sql \
     --host=ops-cla-soa-us-east-1.ce8wli86taiy.us-east-1.rds.amazonaws.com \
     --port=3306 \
     --ssl-ca=/var/folders/pw/p76xjcn926v2hfbs4sry3b700000gr/T//rds-combined-ca-bundle.pem \
     --enable-cleartext-plugin \
     --user=SamlDbReadAccess \
     --password=$password \
     --skip-add-locks \
     --skip-lock-tables \
     --column-statistics=0
}

function dump_prod () {
    database=$1
    password=$2
    mysqldump $database \
     --result-file=/Users/alex.martin/BuiltSource/dump.sql \
     --host=prod-cla-soa-us-east-1.ce8wli86taiy.us-east-1.rds.amazonaws.com \
     --port=3306 \
     --ssl-ca=/var/folders/pw/p76xjcn926v2hfbs4sry3b700000gr/T//rds-combined-ca-bundle.pem \
     --enable-cleartext-plugin \
     --user=SamlDbReadAccess \
     --password=$password \
     --skip-add-locks \
     --skip-lock-tables \
     --column-statistics=0
}

alias gitback='git checkout -'

alias flip='docker container restart inspections-service'

alias cz='cat ~/.zshrc'

function sz () {
    source ~/.zshrc
    config add ~/.zshrc
    ron_quote=$(curl http://ron-swanson-quotes.herokuapp.com/v2/quotes)
    parsed_quote=$(echo "$ron_quote" | sed 's/[]"[]//g')
    config commit -m "$parsed_quote"
    config push
}

function resolve_env () {
    export $(grep -v '^#' .env | xargs)
}

# Database scripts
function trunk () {
    export $(grep -e 'MYSQL_DATABASE' .env | xargs)
    echo 'Blowing up the '${MYSQL_DATABASE} 'database'
    mysql -uroot -pmysqlpassword --execute='DROP DATABASE IF EXISTS '${MYSQL_DATABASE}'; CREATE DATABASE '${MYSQL_DATABASE}';'
    echo 'Seeding the '${MYSQL_DATABASE} 'database'
    mysql -uroot -pmysqlpassword ${MYSQL_DATABASE} < seeds/regression-dump.sql
    alembic upgrade head
}

function local_test () {
    trunk
    pytest
}

function dtest () {
    pytest_args=$1
    export $(grep -e 'SERVICE_NAMESPACE' .env | xargs)
    echo 'Running pytest in docker for '${SERVICE_NAMESPACE}
    docker exec -it ${SERVICE_NAMESPACE} pytest $pytest_args
}

function today () {
    year=$(date +'%Y')
    month=$(date +'%m')
    file=$(date +'%d').txt
    vim ~/Documents/the_daily_mail/$year/$month/$file
}
   
function yest () {
    year=$(date +'%Y')
    month=$(date +'%m')
    file=$(gdate -d "1 day ago" +'%d').txt
    vim ~/Documents/the_daily_mail/$year/$month/$file
}
 
alias reset_lvl_db='python3 manage.py loaddata users tokens gamers game_types games events'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Ruby shit to be removed when not needed
eval "$(rbenv init - zsh)"

alias inspections_db='docker exec -it inspections_db mysql --port=3306 --user=root --password=test --host=inspections_db --database=inspections'
alias ops_bapi_db='awslogin -db=ops-cla-bapi-us-east-1 aws-developer'
export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
alias vz="vim ~/.zshrc"
alias config='/usr/bin/git --git-dir=/Users/alex.martin/.cfg/ --work-tree=/Users/alex.martin'
alias wake_c9='aws ec2 start-instances --region us-east-1 --instance-id i-08d492748e3881d1c'
alias c9='ssh cloud9'
alias nut='pipenv shell'
