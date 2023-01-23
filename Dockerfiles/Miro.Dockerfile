# base image for docker:
FROM osrf/ros:noetic-desktop-full

##########################################################################
# Install common applications:
##########################################################################

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver && \
	apt-get install -y wget && \
	apt-get install -y tar python && \
	apt-get install -y ros-noetic-catkin  && \
	apt-get install -y nano python3-pip curl

RUN apt-get update --fix-missing

# Install ROS tools:
RUN pip3 install -U rosdep rosinstall_generator wstool rosinstall
# Add ROS to bashrc:
RUN bash -c "echo 'source /opt/ros/noetic/setup.bash' >> ~/.bashrc"

##########################################################################
# Robot installations:
#
##########################################################################


# Install miro
###### 	and place this in a folder called mdk within this folder.
#-------------------------------------------------------------------------
RUN apt-get install -y build-essential python3-pip
RUN pip3 install apriltag
RUN apt-get install -y python3-matplotlib python3-tk ffmpeg

# Copy over the MDK, 210921 version below saved in the repo:
## Download link: http://labs.consequentialrobotics.com/download.php?file=mdk_2-210921.tgz

RUN mkdir -p /home/user/mdk
RUN cd /home/user/mdk
RUN curl -X POST http://labs.consequentialrobotics.com/download.php?file=mdk_2-210921.tgz  \
     -H "Content-Type: application/x-www-form-urlencoded"   \
     -d "name=value1&org=value2&email=email@gmail.com&agree=on"  \
     --output /home/user/mdk/mdk_2-210921.tgz 
RUN tar -zxvf /home/user/mdk/mdk_2-210921.tgz -C /home/user/mdk
RUN cd /home/user/mdk/mdk-210921/bin/deb64 && ./install_mdk.sh

#-------------------------------------------------------------------------

##########################################################################
# Set up your environment:
#
## Uncomment block under the title of the tools you want:
##########################################################################

# Add directories from the host, to the guest:
## WORKDIR = Guest directory (within the docker):
WORKDIR "/home/user/"   
## ADD [host_directory_path] [guest_directory_name]
# ADD test test/

## @TODO below not working correctly:
WORKDIR "/home/user/code"

## Auto build your ROS workspace:
# RUN bash -c '. /opt/ros/noetic/setup.bash; cd /home/user/ws; catkin_make'
# RUN bash -c "echo 'source /home/user/ws/devel/setup.bash' >> ~/.bashrc"
