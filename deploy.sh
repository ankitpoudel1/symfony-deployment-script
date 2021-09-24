
#set these values
GIT_REMOTE_URL=

GIT_REMOTE_BRANCH=

PROJECT_ROOT_DIRECTORY=
########################################################################

cd $PROJECT_ROOT_DIRECTORY 

CURRENT_TIME=$(date +%s)


if [ ! -d "releases" ]
then
mkdir releases
fi

cd releases
git clone $GIT_REMOTE_URL $CURRENT_TIME 

cd $CURRENT_TIME
git checkout $GIT_REMOTE_BRANCH

if [ ! -d "${PROJECT_ROOT_DIRECTORY}/current" ]
then
ln -s ${PROJECT_ROOT_DIRECTORY}/releases/${CURRENT_TIME}/ ${PROJECT_ROOT_DIRECTORY}/current
else
ln -nsf ${PROJECT_ROOT_DIRECTORY}/releases/${CURRENT_TIME}/ ${PROJECT_ROOT_DIRECTORY}/current
fi

cd ${PROJECT_ROOT_DIRECTORY}/current

composer install

if [ ! -d "${PROJECT_ROOT_DIRECTORY}/shared" ]
then
    mkdir ${PROJECT_ROOT_DIRECTORY}/shared
    cd ${PROJECT_ROOT_DIRECTORY}/shared 
    touch .env.local
fi


ln -s ${PROJECT_ROOT_DIRECTORY}/shared/uploads/ ${PROJECT_ROOT_DIRECTORY}/current/public/uploads

rm -rf ${PROJECT_ROOT_DIRECTORY}/current/var
ln -s ${PROJECT_ROOT_DIRECTORY}/shared/var/ ${PROJECT_ROOT_DIRECTORY}/current/var


rm ${PROJECT_ROOT_DIRECTORY}/current/.env

ln -s ${PROJECT_ROOT_DIRECTORY}/shared/.env.local ${PROJECT_ROOT_DIRECTORY}/current/.env

cd ${PROJECT_ROOT_DIRECTORY}/current

bin/console doctrine:schema:update --force --dump-sql



echo "Successfully deployed"
