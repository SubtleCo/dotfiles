
# Shit for Weasyprint & Title Service
export DYLD_FALLBACK_LIBRARY_PATH="$HOME/lib:/usr/local/lib:/usr/lib:/opt/homebrew/lib"


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
alias prod_bapi_db='awslogin -db=prod-cla-bapi-replica-us-east-1 prod-support'
alias staging_db='awslogin -db=staging-cla-soa-us-east-1 aws-developer'
alias staging_bapi_db='awslogin -db=staging-cla-bapi-us-east-1 aws-developer'
alias ops_bapi_db='awslogin -db=ops-cla-bapi-us-east-1 aws-developer'
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

function gen_c9_hash () {
    name=$1
    python ~/BuiltSource/my_scripts/c9_hash_gen.py $name
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


function c9_hash () {
    echo "c63d7a6b" | pbcopy
}

# Opening repos in nvim
function app () {
  cd ~/BuiltSource/inspections-miniapp
  nvim . 
}

function pap () {
  cd ~/BuiltSource/inspections-product-api
  nvim .
}

function ser () {
  cd ~/BuiltSource/inspections-service/
  pipenv shell && nvim .
}

# Database extraction
function init_built_tools() {
    colima start
    cd $HOME/BuiltSource/developer-environment
    awslogin aws-developer
    mv $HOME/.aws/aws-developer $HOME/.aws/credentials
    pipenv run built_up -p minimal
}

function prod_extract_loan() {
    cd $HOME/BuiltSource/case_sensitive/built-tools
    ./bin/built extract loan $1 -o "$1.sql"
    mv $HOME/.built/cache/$1.sql $HOME/BuiltSource/prod-extracts/$1.sql
}

function prod_extract_lender() {
    cd $HOME/BuiltSource/case_sensitive/built-tools
    ./bin/built extract lender $1 -o "$1.sql"
    mv $HOME/.built/cache/$1.sql $HOME/BuiltSource/prod-extracts/$1.sql
}

function prod_extract_user() {
    cd $HOME/BuiltSource/case_sensitive/built-tools
    ./bin/built extract user $1 -o "$1.sql"
    mv $HOME/.built/cache/$1.sql $HOME/BuiltSource/prod-extracts/$1.sql
}




###########
# ALIASES #
###########
alias ecrlogin='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 833816692833.dkr.ecr.us-east-1.amazonaws.com'
alias inspections_db='docker exec -it inspections_db mysql --port=3306 --user=root --password=test --host=inspections_db --database=inspections'
alias docks='docker ps --format "table {{.Names}}\t{{.Command}}\t{{.Status}}"'
alias title_db='docker exec -it title_db mysql --port=3306 --user=root --password=test --host=title_db --database=title'
alias gmd='git merge develop'
