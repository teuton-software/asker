# Create docker container
# Using volumen for persistet data

DNAME=asker
DIMAGE=dvarrui/asker
DVOLUME=$PWD

docker run -it --rm --name $DNAME -v $DVOLUME:/opt -w /opt $DIMAGE 

