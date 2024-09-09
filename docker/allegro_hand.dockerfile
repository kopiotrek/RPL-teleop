FROM apojomovsky/gz9_kinetic_colcon
ENTRYPOINT ["/bin/bash"]

# Update and install necessary packages
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y software-properties-common wget git curl

# Clone the GitHub repository
RUN git clone https://github.com/gpldecha/allegro-hand.git \
  && cd allegro-hand \
  && chmod +x install_dependencies.sh \
  && ./install_dependencies.sh

RUN cd allegro-hand \
  && chmod +x install_gazebo_source.sh \
  && sudo ./install_gazebo_source.sh

RUN cd allegro-hand/ahand_gazebo \
  && rm CATKIN_IGNORE

  # https://www.peak-system.com/quick/PCAN-Linux-Driver

  # https://www.peak-system.com/fileadmin/media/linux/files/pcan-kernel-version.sh.tar.gz

  # 1. Zmienic paczke z repo na ta z linku powyzej i zbudowac make install
# =======================================
  # apt-get install linux-image-5.8.0-63-generic linux-headers-5.8.0-63-generic
  

#   FROM tbasa/tb_ubuntu16
# ENTRYPOINT ["/bin/bash"]


# # Update and install necessary packages
# RUN DEBIAN_FRONTEND=noninteractive \
#   apt-get update \
#   && apt-get install -y software-properties-common wget git curl

# # Update and install necessary packages
# RUN DEBIAN_FRONTEND=noninteractive \
#   && sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' \
#   && curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add - \
#   && apt-get update \
#   && apt-get install -y ros-kinetic-desktop-full

# RUN DEBIAN_FRONTEND=noninteractive \
#   && echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc \
#   && apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential \
#   && rosdep init \
#   && rosdep update -y

# # Clone the GitHub repository
# RUN git clone https://github.com/gpldecha/allegro-hand.git \
#   && cd allegro-hand \
#   && chmod +x install_dependencies.sh \
#   && ./install_dependencies.sh

# RUN cd allegro-hand \
#   && chmod +x install_gazebo_source.sh \
#   && sudo ./install_gazebo_source.sh

# RUN cd allegro-hand/ahand_gazebo \
#   && rm CATKIN_IGNORE