FROM ros:kinetic-ros-core

COPY . /home/catkin_ws/src/

RUN apt-get -qq update \
        && apt-get install -y sudo netcat \
        && rosdep install --as-root apt:yes -r --from-paths /home/catkin_ws/ --ignore-src --rosdistro kinetic -y \
        && rm -rf /var/lib/apt/lists/*

SHELL ["bin/bash", "-c"]

RUN source /opt/ros/kinetic/setup.bash \
        && cd /home/catkin_ws/ \
        && catkin_make

CMD cd /home/catkin_ws \
        && source devel/setup.bash \
        && roslaunch velodyne_pointcloud VLP16_points.launch 
