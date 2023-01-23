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
	apt-get install -y nano python3-pip  

RUN apt-get update --fix-missing

# Install ROS tools:
RUN pip3 install -U rosdep rosinstall_generator wstool rosinstall
# Add ROS to bashrc:
RUN bash -c "echo 'source /opt/ros/noetic/setup.bash' >> ~/.bashrc"

##########################################################################
# Robot installations:
##########################################################################


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
