# FROM tbasa/tb_ubuntu16
FROM ubuntu:20.04
ENTRYPOINT ["/bin/bash"]

# Set timezone environment variable to prevent interactive prompt
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Update and install necessary packages
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y software-properties-common wget git curl g++ nano

# ROS noetic install
RUN DEBIAN_FRONTEND=noninteractive \
  && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
  && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
  && apt-get update

RUN DEBIAN_FRONTEND=noninteractive \
  && echo 'keyboard-configuration keyboard-configuration/layoutcode string us' | debconf-set-selections \
  && apt-get install -y ros-noetic-desktop-full

RUN DEBIAN_FRONTEND=noninteractive \
  && echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc \
  && apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential \
  && rosdep init \
  && rosdep update -y

RUN DEBIAN_FRONTEND=noninteractive \
  && apt install -y ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control

  RUN DEBIAN_FRONTEND=noninteractive \
  && apt install -y ufw iproute2 iputils-ping netcat nmap

# !!! nano /etc/default/ufw and IPV6=no !!!