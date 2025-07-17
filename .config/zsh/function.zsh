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


sz () {
    source ~/.zshrc

    # Set personal git identity just for this repo
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config user.name "subtleco"
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME config user.email "raymond.alex.martin@gmail.com"

    # Make sure you're using the right remote
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME remote set-url origin git@github.com-personal:yourusername/dotfiles.git

    # Add tracked files
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME add ~/.zshrc ~/.config/zsh ~/.config/nvim ~/.config/tmux

    # Get Ron quote
    ron_quote=$(curl -s http://ron-swanson-quotes.herokuapp.com/v2/quotes | sed 's/[\[\]"]//g')

    # Commit with quote
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME commit -m "$ron_quote"

    # Push using correct SSH key
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME push
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

########
# SYNE #
########

function refresh_spotify_token() {
  curl -X POST "https://accounts.spotify.com/api/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "client_id=$SPOTIFY_CLIENT_ID" \
    -d "client_secret=$SPOTIFY_CLIENT_SECRET" \
    -d "grant_type=refresh_token" \
    -d "refresh_token=$SPOTIFY_REFRESH_TOKEN"
}

function get_spotify_app_token() {
  curl -X POST "https://accounts.spotify.com/api/token" \
   -H "Content-Type: application/x-www-form-urlencoded" \
   -d "grant_type=client_credentials&client_id=$SPOTIFY_CLIENT_ID&client_secret=$SPOTIFY_CLIENT_SECRET"
}

function get_spotify_uat() {
  curl -s -X POST "https://accounts.spotify.com/api/token" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "client_id=$SPOTIFY_CLIENT_ID" \
    -d "client_secret=$SPOTIFY_CLIENT_SECRET" \
    -d "grant_type=authorization_code" \
    -d "code=$SPOTIFY_AUTH_CODE" \
    -d "redirect_uri=$SPOTIFY_REDIRECT_URI"
}

function oh god(){
  docker system prune -a -f
}

