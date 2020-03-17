# build docker image
docker build -t python377:1.0.0 .

$command=$args[0]
if ($command -eq "start") {
    # run container
    ## for Windows
    docker run -p 8888:8888 --name container_python377 -v ${pwd}\source:/home  python377:1.0.0
}
else {
    # delete container, image and volume
    ## stop all containers
    docker stop $(docker ps -aq)

    ## remove all containers
    docker rm -f $(docker ps -aq)

    ## remove all docker images
    #docker image prune -a -f

    ## remove all volume
    docker volume prune -f 
}

docker image ls 
docker ps