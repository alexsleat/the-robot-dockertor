# base image for docker:
FROM ubuntu:20.04

##########################################################################
# Install common applications:
##########################################################################

#ENV PYTHON_VERSION 3.7.7
#ENV PYTHON_PIP_VERSION 20.1

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update && \
    apt-get install -y gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal && \
    apt-get install -y tightvncserver && \
	apt-get install -y wget && \
	apt-get install -y tar python && \
	apt-get install -y nano python3-pip  

RUN apt-get update --fix-missing

##########################################################################
# Robot installations:
#
## Uncomment block under the title of the tools you want:
##########################################################################

# Install cozmo
RUN apt-get install -y cython3 python3-pyaudio
RUN pip3 install cozmo numpy
RUN apt-get install -y android-tools-adb 


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
