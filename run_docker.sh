. docker_config

docker run \
    -v $(pwd)/code:/home/user/code \
    --rm \
    -it \
    --privileged \
    -v /dev/bus/usb:/dev/bus/usb \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    --name $CONTAINER_NAME \
    $DOCKER_NAME bash                           
