# Intro

For more infomation on docker, check out the quick start guide: https://docs.docker.com/get-started/

This repo will provide a few options of ROS + robot combinations to get started with the SORO robots quickly and without the hassle of setup. 

Switch to the branch you want and copy the Dockerfile to your project folder. 

This branch will remain for documents.

## Example Usage:

### Replace the Dockerfile

Inside the "Dockerfiles" folder, you will find several files for each robot. Replace the main "Dockerfile" in the root dir, with the file you want. Rename it "Dockerfile"

### Inside the config file, modify the names:

    DOCKER_NAME="dockertor-melodic"
    CONTAINER_NAME="test_melodic"

### Select the correct Dockerfile you want (The exact name of the file, within the Dockerfiler dir but without the file extension), eg:

    DOCKER_ROBOT="PepperNAO"


### Add your code:
Add you code to the code directory - this will allow you to edit the code from the host machine (in your normal editor) and the changes are shared with the container. It will also provide you persistant storage (you can add more directories, as you wish) so you never need to transfer files from the container to the host.

#### Note:

For the remaining, replace "dockertor-melodic", and "test_melodic" to fit your config file.

### To build:
_navigate to the directory_

    . build_docker.sh

### To run:
    . run_docker.sh

### To attach (open another terminal inside the container):
    . attach_docker.sh

## Notes:

- When using multiple robots, you can boot several containers. You may be able to mash some dockerfiles together in order have them both running. But this can be a problem when requirements differ. I.e Miro requries ROS Noetic but Pepper does not work with the version of Ubuntu that supports it - (this might not be true, but note worthy while creating your dockers)

# Useful docker commands

See running containers

    docker ps

See filesystem usage

    docker system df

Clean up space

    docker image prune
    docker container prune
    docker builder prune

Restart docker

    systemctl restart docker



# run_docker.sh

As it's not possible to comment multiline commands, I'm adding descriptions of the arguments for the script here. You can use as many as you want as long as the formatting is correct (i.e the line ends with a '\' character ).

Do not include the comments. See the default file for an example of how it should look, compared to what's here.

    docker run \
        -v $(pwd)/code:/home/user/code \            # Mount the code folder in the current DIR - put your code here and you can edit outside the container
        --rm \                                      # Deletes the container once stopped. Use above for persistant files
        -it \                                       # interactive +tty - drops you in the containers terminal once running
        --privileged \                              # Grants access to much of the system
    # --- USB -------------------------------------------------------------------------------------------------------
        -v /dev/bus/usb:/dev/bus/usb \              # Mounts the usb bus to the container
    # --- Display ---------------------------------------------------------------------------------------------------
        -e DISPLAY=$DISPLAY \                       # Sets the display as host (should allow GUI)
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \       # Mounts X11 (also retuired for GUI)
    # --- Network pors ----------------------------------------------------------------------------------------------
        -p 12345:12345 \                            # Example of opening a port from the container to the host ip
    # --- Pulse Audio / Mic and Speakers - Too much to comment, but it's all needed... I think ----------------------
        -v /dev/snd:/dev/snd  \
        -v /run/user/$uid/puslse:/run/user/$uid/pulse \
        -v /dev/shm:/dev/shm \
        -v /etc/machine-id:/etc/machine-id \
        -v /var/lib/dbus:/var/lib/dbus \
        -v ~/.pulse:/home/$dockerUsername/.pulse \
        -v ~/.config/pulse/cookie:/root/.config/pulse/cookie \
        -e PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native \
        -v ${XDG_RUNTIME_DIR}/pulse/native:${XDG_RUNTIME_DIR}/pulse/native \
        --device /dev/snd \
    # ---------------------------------------------------------------------------------------------------------------
        $DOCKER_NAME bash                           # Runs the container with the name from config file




# Additional Notes:

Some great examples can be found on this github repo - https://github.com/jessfraz/dockerfiles
