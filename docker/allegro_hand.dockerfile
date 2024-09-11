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

# ROS kinetic install
# RUN DEBIAN_FRONTEND=noninteractive \
#   && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#   && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
#   && apt-get update \
#   && apt-get install -y ros-kinetic-desktop-full

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


# Clone the GitHub repository
RUN mkdir catkin_ws \
  && cd catkin_ws \
  && git clone https://github.com/kopiotrek/allegro-hand.git \
  && mv allegro-hand src \
  && cd src \
  && chmod +x install_dependencies.sh \
  && ./install_dependencies.sh

RUN DEBIAN_FRONTEND=noninteractive \
  && apt install -y ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control


RUN wget https://www.peak-system.com/quick/PCAN-Linux-Driver \
  && tar -xzf PCAN-Linux-Driver

# !!! HAS TO BE INSTALLED ON THE HOST MACHINE !!!
#
# For installing g++:
# Add the following line to /etc/apt/sources.list:
# deb http://archive.ubuntu.com/ubuntu/ focal-proposed main
 
#
# RUN wget https://www.peak-system.com/quick/PCAN-Linux-Driver \
#   && tar -xzf PCAN-Linux-Driver \
#   && cd peak-linux-driver-8.18.0 \
#   && make \
#   && make install

# RUN cd allegro-hand \
#   && chmod +x install_gazebo_source.sh \
#   && sudo ./install_gazebo_source.sh



RUN cd catkin_ws/src/ahand_gazebo \
  && rm CATKIN_IGNORE

  # https://www.peak-system.com/quick/PCAN-Linux-Driver

  # 1. Zmienic paczke z repo na ta z linku powyzej i zbudowac make install
# =======================================
  # apt-get install linux-image-5.8.0-63-generic linux-headers-5.8.0-63-generic
  