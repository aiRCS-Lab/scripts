sudo apt-get update && sudo apt-get -y --quiet --no-install-recommends install \
		bzip2 \
		ca-certificates \
		ccache \
		cmake \
		cppcheck \
		curl \
		dirmngr \
		doxygen \
		file \
		g++ \
		gcc \
		gdb \
		git \
		gnupg \
		gosu \
		lcov \
		libfreetype6-dev \
		libgtest-dev \
		libpng-dev \
		libssl-dev \
		lsb-release \
		make \
		ninja-build \
		openjdk-8-jdk \
		openjdk-8-jre \
		openssh-client \
		pkg-config \
		python3-dev \
		python3-pip \
		rsync \
		shellcheck \
		tzdata \
		unzip \
		valgrind \
		wget \
		xsltproc \
		zip \
	&& sudo apt-get -y autoremove \
	&& sudo apt-get clean autoclean \
	&& sudo rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

sudo cd /usr/src/gtest \
	&& sudo mkdir build && cd build \
	&& sudo cmake .. && make -j$(nproc) \
	&& sudo find . -name \*.a -exec cp {} /usr/lib \; \
	&& sudo cd .. && sudo rm -rf build

python3 -m pip install --upgrade pip wheel setuptools

python3 -m pip install argparse argcomplete coverage cerberus empy jinja2 kconfiglib \
		matplotlib==3.0.* numpy nunavut>=1.1.0 packaging pkgconfig pyros-genmsg pyulog \
		pyyaml requests serial six toml psutil pyulog wheel jsonschema pynacl

sudo ln -s /usr/bin/ccache /usr/lib/ccache/cc \
	&& sudo ln -s /usr/bin/ccache /usr/lib/ccache/c++

sudo wget -q https://downloads.sourceforge.net/project/astyle/astyle/astyle%203.1/astyle_3.1_linux.tar.gz -O /tmp/astyle.tar.gz \
	&& sudo cd /tmp && sudo tar zxf astyle.tar.gz && sudo cd astyle/src \
	&& sudo make -f ../build/gcc/Makefile -j$(nproc) && sudo cp bin/astyle /usr/local/bin \
	&& sudo rm -rf /tmp/*

sudo wget -q "https://services.gradle.org/distributions/gradle-6.3-rc-4-bin.zip" -O /tmp/gradle-6.3-rc-4-bin.zip \
	&& sudo mkdir /opt/gradle \
	&& sudo cd /tmp \
	&& sudo unzip -d /opt/gradle gradle-6.3-rc-4-bin.zip \
	&& sudo rm -rf /tmp/*

sudo git clone https://github.com/eProsima/foonathan_memory_vendor.git /tmp/foonathan_memory \
	&& sudo cd /tmp/foonathan_memory \
	&& sudo mkdir build && cd build \
	&& sudo cmake .. \
	&& sudo cmake --build . --target install -- -j $(nproc) \
	&& sudo rm -rf /tmp/*

sudo git clone --recursive https://github.com/eProsima/Fast-DDS.git -b v2.0.2 /tmp/FastDDS-2.0.2 \
	&& sudo cd /tmp/FastDDS-2.0.2 \
	&& sudo mkdir build && cd build \
	&& sudo cmake -DTHIRDPARTY=ON -DSECURITY=ON .. \
	&& sudo cmake --build . --target install -- -j $(nproc) \
	&& sudo rm -rf /tmp/*

sudo git clone --recursive https://github.com/eProsima/Fast-DDS-Gen.git -b v1.0.4 /tmp/Fast-RTPS-Gen-1.0.4 \
	&& cd /tmp/Fast-RTPS-Gen-1.0.4 \
	&& sudo gradle assemble \
	&& sudo gradle install \
	&& sudo rm -rf /tmp/*

sudo useradd --shell /bin/bash -u 1001 -c "" -m user && usermod -a -G dialout user

sudo mkdir /tmp/.X11-unix && \
	sudo chmod 1777 /tmp/.X11-unix && \
	sudo chown -R root:root /tmp/.X11-unix

sudo wget --quiet http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - \
	&& sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -sc` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
	&& sudo apt-get update \
	&& DEBIAN_FRONTEND=noninteractive sudo apt-get -y --quiet --no-install-recommends install \
		ant \
		binutils \
		bc \
		dirmngr \
		gazebo11 \
		gstreamer1.0-plugins-bad \
		gstreamer1.0-plugins-base \
		gstreamer1.0-plugins-good \
		gstreamer1.0-plugins-ugly \
		libeigen3-dev \
		libgazebo11-dev \
		libgstreamer-plugins-base1.0-dev \
		libimage-exiftool-perl \
		libopencv-dev \
		libxml2-utils \
		mesa-utils \
		protobuf-compiler \
		x-window-system \
		ignition-edifice \
	&& sudo apt-get -y autoremove \
	&& sudo apt-get clean autoclean \
	&& sudo rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

wget https://github.com/JSBSim-Team/jsbsim/releases/download/v1.1.1a/JSBSim-devel_1.1.1-134.focal.amd64.deb
sudo dpkg -i JSBSim-devel_1.1.1-134.focal.amd64.deb

sudo curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' \
	&& sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-latest.list' \
	&& sudo sh -c 'echo "deb http://packages.ros.org/ros-shadow-fixed/ubuntu `lsb_release -sc` main" > /etc/apt/sources.list.d/ros-shadow.list' \
	&& sudo apt-get update \
	&& sudo apt-get -y --quiet --no-install-recommends install \
		geographiclib-tools \
		libeigen3-dev \
		libgeographic-dev \
		libopencv-dev \
		libyaml-cpp-dev \
		python3-rosdep \
		python3-catkin-tools \
		python3-catkin-lint \
		ros-noetic-gazebo-ros-pkgs \
		ros-noetic-mavlink \
		ros-noetic-mavros \
		ros-noetic-mavros-extras \
		ros-noetic-octomap \
		ros-noetic-octomap-msgs \
		ros-noetic-pcl-conversions \
		ros-noetic-pcl-msgs \
		ros-noetic-pcl-ros \
		ros-noetic-ros-base \
		ros-noetic-rostest \
		ros-noetic-rosunit \
		python3-catkin-tools \
		python3-rosinstall-generator\
		python3-wstool \
		xvfb \
		vim \
	&& sudo geographiclib-get-geoids egm96-5 \
	&& sudo apt-get -y autoremove \
	&& sudo apt-get clean autoclean \
	&& sudo rm -rf /var/lib/apt/lists/{apt,dpkg,cache,log} /tmp/* /var/tmp/*

pip3 install -U \
		osrf-pycommon

wget https://raw.githubusercontent.com/mavlink/mavros/master/mavros/scripts/install_geographiclib_datasets.sh && sudo bash ./install_geographiclib_datasets.sh

sudo rosdep init && rosdep update

git clone https://github.com/PX4/PX4-Autopilot.git --recursive /home/$USER/PX4-Firmware/

echo 'source ~/PX4-Firmware/Tools/simulation/gazebo/setup_gazebo.bash ~/PX4-Firmware ~/PX4-Firmware/build/px4_sitl_default' >> /home/user/.bashrc
echo 'export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Firmware' >> /home/user/.bashrc
echo 'export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:~/PX4-Firmware/Tools/simulation/gazebo/sitl_gazebo' >> /home/user/.bashrc
echo 'export GAZEBO_PLUGIN_PATH=$GAZEBO_PLUGIN_PATH:/usr/lib/x86_64-linux-gnu/gazebo-9/plugins' >> /home/user/.bashrc