#set these values
REMOTE_SERVER=
REMOTE_USER=
####################################################################
scp deploy.sh $REMOTE_USER@$REMOTE_SERVER:/tmp && ssh -t $REMOTE_USER@$REMOTE_SERVER bash /tmp/deploy.sh
