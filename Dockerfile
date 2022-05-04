FROM ubuntu:20.04

# https://linuxize.com/post/how-to-install-opencv-on-ubuntu-20-04/ を参考にDockerfile作成

# ubuntu update
RUN apt-get -y update && apt-get -y upgrade

RUN DEBIAN_FRONTEND=noninteractive TZ=Asia/Tokyo apt-get -y install git tzdata
RUN apt-get -y install libopencv-dev python3-opencv

RUN apt-get install -y build-essential cmake git pkg-config libgtk-3-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libxvidcore-dev libx264-dev libjpeg-dev libpng-dev libtiff-dev \
    gfortran openexr libatlas-base-dev python3-dev python3-numpy \
    libtbb2 libtbb-dev libdc1394-22-dev libopenexr-dev \
    libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev

RUN mkdir ~/opencv_build && cd ~/opencv_build && \
    git clone https://github.com/opencv/opencv.git && \ 
    git clone https://github.com/opencv/opencv_contrib.git && \
    cd ~/opencv_build/opencv && \
    mkdir -p build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_GENERATE_PKGCONFIG=ON \
    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_build/opencv_contrib/modules \
    -D BUILD_EXAMPLES=ON .. && \
    make -j8 && \
    make install
