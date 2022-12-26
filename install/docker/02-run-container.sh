# Create docker container
# Using volumen for persistet data

NAME=asker
IMAGE=dvarrui/asker
VOLUME=$PWD
CMD="$1 $2 $3 $4"

docker run -it --rm --name $NAME -v $VOLUME:/opt -w /opt $IMAGE  $CMD

