#!/bin/bash
# build docker image
docker build -t python377:1.0.0 . &&

if [ "$1" == "start" ]
then
    # run container
    docker run -p 8888:8888 --name container_python377 -v $(pwd)/source:/home  python377:1.0.0
else
    # delete container, image and volume
    ## stop all containers
    docker stop $(docker ps -aq) && 

    ## remove all containers
    docker rm -f $(docker ps -aq) &&

    ## remove all docker images
    #docker image prune -a -f &&

    ## remove all volume
    docker volume prune -f
fi
docker image ls &&
docker ps