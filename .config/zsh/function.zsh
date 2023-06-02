###########################
# General Shell Functions #
###########################


mg () {
  # Create a directory {name} and move into it
    mkdir -p "$1" && cd $_
}


in () {
  # list the contents of a {dir}
    cd $1
    ls
}


alias config='/usr/bin/git --git-dir=/Users/alex.martin/.cfg/ --work-tree=/Users/alex.martin'
function sz () {
    source ~/.zshrc
    config add ~/.zshrc ~/.config/zsh ~/.config/nvim ~/.config/tmux
    ron_quote=$(curl http://ron-swanson-quotes.herokuapp.com/v2/quotes)
    parsed_quote=$(echo "$ron_quote" | sed 's/[]"[]//g')
    config commit -m "$parsed_quote"
    config push
}


function envs () {
    export $(grep -v '^#' .env | xargs)
}


###########
# JOURNAL #
###########

function today () {
    year=$(date +'%Y')
    month=$(date +'%m')
    file=$(date +'%d').txt
    lvim ~/Documents/the_daily_mail/$year/$month/$file
}

function yest () {
    year=$(date +'%Y')
    month=$(date +'%m')
    file=$(gdate -d "1 day ago" +'%d').txt
    lvim ~/Documents/the_daily_mail/$year/$month/$file
}

function navi() {
  thing=$1
    curl -s https://api.openai.com/v1/chat/completions \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer $OPENAI_API_KEY" \
      -d '{
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "'"$thing"'"}]
      }' | jq -r '.choices[0].message.content'
}

