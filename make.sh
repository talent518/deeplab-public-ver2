#!/bin/sh

apt-get install libhdf5-dev libopencv-*
export CFLAGS="`pkg-config --cflags hdf5 opencv`"
export CXXFLAGS="`pkg-config --cflags hdf5 opencv`"
export NVCCFLAGS="`pkg-config --cflags hdf5 opencv`"
export LDFLAGS="`pkg-config --cflags --libs hdf5 opencv | sed 's|-lippicv||g'` `pkg-config --libs-only-L hdf5 opencv | sed 's|-L|-Wl,-rpath,|g'`"
export DISTRIBUTE_DIR=/usr/local
make
