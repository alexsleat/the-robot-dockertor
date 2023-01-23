# base image for docker:
FROM osrf/ros:melodic-desktop-full

##########################################################################
# Install common applications:
##########################################################################

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver && \
	apt-get install -y wget && \
	apt-get install -y tar python && \
	apt-get install -y ros-melodic-catkin  && \
	apt-get install -y python-pip nano python3-pip  

RUN apt-get update --fix-missing

# Install ROS tools:
RUN pip3 install -U rosdep rosinstall_generator wstool rosinstall
# Add ROS to bashrc:
RUN bash -c "echo 'source /opt/ros/melodic/setup.bash' >> ~/.bashrc"

##########################################################################
# Robot installations:
#
##########################################################################

# Install Pepper/NAO

## Install Choregraphe Suite 2.5.5.5
#-------------------------------------------------------------------------
RUN wget --no-check-certificate -P /opt/Softbank\ Robotics/ https://community-static.aldebaran.com/resources/2.5.10/Choregraphe/choregraphe-suite-2.5.10.7-linux64-setup.run
RUN chmod +x /opt/Softbank\ Robotics/choregraphe-suite-2.5.10.7-linux64-setup.run
RUN /opt/Softbank\ Robotics/choregraphe-suite-2.5.10.7-linux64-setup.run --mode unattended
RUN rm /opt/Softbank\ Robotics/choregraphe-suite-2.5.10.7-linux64-setup.run
RUN sudo mv /opt/Softbank\ Robotics/Choregraphe\ Suite\ 2.5/lib/libz.so.1 libz.so.1.old
RUN sudo ln -s /opt/Softbank\ Robotics/Choregraphe\ Suite\ 2.5/lib/x86_64-linux-gnu/libz.so.1
#-------------------------------------------------------------------------

# Install pynaoqi 2.5.5.5 library
#-------------------------------------------------------------------------
RUN wget --no-check-certificate -P /root/ https://community-static.aldebaran.com/resources/2.5.10/Python%20SDK/pynaoqi-python2.7-2.5.7.1-linux64.tar.gz
RUN tar -xvzf /root/pynaoqi-python2.7-2.5.7.1-linux64.tar.gz -C /root/
RUN rm /root/pynaoqi-python2.7-2.5.7.1-linux64.tar.gz
ENV PYTHONPATH /root/pynaoqi-python2.7-2.5.7.1-linux64/lib/python2.7/site-packages
ENV LD_LIBRARY_PATH /opt/Aldebaran/lib/
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
# RUN bash -c '. /opt/ros/melodic/setup.bash; cd /home/user/ws; catkin_make'
# RUN bash -c "echo 'source /home/user/ws/devel/setup.bash' >> ~/.bashrc"
