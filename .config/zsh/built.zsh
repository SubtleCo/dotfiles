
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


###########
# ALIASES #
###########
alias ecrlogin='aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 833816692833.dkr.ecr.us-east-1.amazonaws.com'
alias inspections_db='docker exec -it inspections_db mysql --port=3306 --user=root --password=test --host=inspections_db --database=inspections'
alias docks='docker ps --format "table {{.Names}}\t{{.Command}}\t{{.Status}}"'
alias title_db='docker exec -it title_db mysql --port=3306 --user=root --password=test --host=title_db --database=title'
alias gmd='git merge develop'