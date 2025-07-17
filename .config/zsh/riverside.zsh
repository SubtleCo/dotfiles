export LOCALSTACK_AUTH_TOKEN="ls-xEQAfiSA-HEdi-xOxo-5172-JomO64206e39" 

alias staging="aws ssm start-session --region us-east-1 --target i-0cacbb41297e31492 --document-name AWS-StartPortForwardingSessionToRemoteHost --parameters host=\"192.168.242.71\",portNumber=\"1435\",localPortNumber=\"9999\" --profile pre-rsi-group-platform"
alias laws="awslocal --profile localstack"
alias daws="aws --profile pre-rsi-group-platform"
alias saws="aws --profile dev-rsi-group-sandbox"
alias ssdaws="aws --profile pre-rsi-shared-services"

alias db-rostering='harlequin -a postgres "postgres://rostering_owner:L0calRS1D3v@localhost:5432/rostering"'
