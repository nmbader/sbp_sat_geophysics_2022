FROM ubuntu:18.04 as builder
MAINTAINER nmbader@sep.stanford.edu
RUN apt-get -y update
RUN apt-get -y install build-essential
RUN apt-get -y install libelf-dev libffi-dev
RUN apt-get -y install pkg-config
RUN apt-get -y install wget git gcc g++ gfortran make cmake vim lsof
RUN apt-get -y install flex libxaw7-dev
RUN apt-get -y install libfftw3-3 libfftw3-dev libssl-dev

RUN apt-get -y  install python3-pip
RUN python3 -m pip install --no-cache-dir --upgrade pip

RUN python3 -m pip install --no-cache-dir numpy &&\
    python3 -m pip install --no-cache-dir jupyter &&\
    python3 -m pip install --no-cache-dir scipy &&\
    python3 -m pip install --no-cache-dir matplotlib

RUN mkdir -p /opt/ispc/bin
RUN mkdir -p /home
RUN mkdir -p /home/sbp_sat_geophysics_2022
WORKDIR /home

RUN wget https://github.com/ispc/ispc/releases/download/v1.17.0/ispc-v1.17.0-linux.tar.gz  &&\
    tar -xvf ispc-v1.17.0-linux.tar.gz &&\
    cp ispc-v1.17.0-linux/bin/ispc /opt/ispc/bin/ &&\
    rm -f ispc-v1.17.0-linux.tar.gz  &&\
    rm -rf ispc-v1.17.0-linux

RUN cd /opt &&\
    git clone https://github.com/nmbader/fwi2d.git &&\
    cd fwi2d  &&\
    git checkout 1b20e7ee0bbe06eb43cbee18c91d7ed29809a8e4  &&\
    mkdir -p build local  &&\
    cd external/SEP &&\
    bash ./buildit.sh &&\
    cd ../../build  &&\
    cmake -DCMAKE_INSTALL_PREFIX=../local -DISPC=/opt/ispc/bin/ispc ../  &&\
    make -j12  &&\
    make install &&\
    cd ../ &&\
    rm -rf build

RUN cd /opt &&\
    git clone --recursive --branch devel https://github.com/geodynamics/specfem2d.git &&\
    cd specfem2d  &&\
    ./configure FC=gfortran CC=gcc &&\
    make

ADD notebooks /home/sbp_sat_geophysics_2022/notebooks
ADD specfem2d /home/sbp_sat_geophysics_2022/specfem2d
ADD README.md /home/sbp_sat_geophysics_2022

RUN ls -s /opt/specfem2d/bin/xmeshfem2D /home/sbp_sat_geophysics_2022/specfem2d
RUN ls -s /opt/specfem2d/bin/xspecfem2d /home/sbp_sat_geophysics_2022/specfem2d

RUN apt-get -y clean

ENV HOME=/home 
ENV PATH="/opt/fwi2d/bin:${PATH}"
ENV DATAPATH="/tmp/"
RUN echo 'alias python=python3' >> ~/.bashrc