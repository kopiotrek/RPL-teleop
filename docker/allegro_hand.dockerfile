FROM liang0523/ros-noetic
ENTRYPOINT ["/bin/bash"]

# Update and install necessary packages
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y software-properties-common wget git curl

# Clone the GitHub repository
RUN git clone https://github.com/kopiotrek/allegro-hand.git \
  && cd allegro-hand \
  && chmod +x install_dependencies.sh \
  && ./install_dependencies.sh

RUN cd allegro-hand \
  && chmod +x install_gazebo_source.sh \
  && sudo ./install_gazebo_source.sh

RUN cd allegro-hand/ahand_gazebo \
  && rm CATKIN_IGNORE

  https://www.peak-system.com/quick/PCAN-Linux-Driver

  https://www.peak-system.com/fileadmin/media/linux/files/pcan-kernel-version.sh.tar.gz

  1. Zmienic paczke z repo na ta z linku powyzej i zbudowac make install
  