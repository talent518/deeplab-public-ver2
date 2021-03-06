## DeepLab v2

### 编译要求(ubuntu16.04编译通过)
  1. 必须是gcc 5.0以上版本；
  2. 必须安装库：opencv,boost,matio,cuda,hdf5,atlas,blas,protobuf,glob,gflags；
  3. cmake编译时需要禁用cudnn，命令如下：
```
    mkdir build
    cd build
    cmake .. -DUSE_CUDNN=OFF
    make
```
  4. 紧CPU模式，命令如下：
```
    cmake  .. -DCPU_ONLY=ON -DCMAKE_CXX_FLAGS="-I/usr/local/cuda/include"
```
  5. [ubuntu上Caffe使用OpenBLAS多线程加速](http://blog.csdn.net/u013983674/article/details/71479849)
```
    apt install libopenblas-dev
    
    cmake  .. -DCPU_ONLY=ON -DCMAKE_CXX_FLAGS="-I/usr/local/cuda/include" -DBLAS=open
    export OPENBLAS_NUM_THREADS=6
    cd exper
    ./run_pascal_cpu.sh
```
  6. centos编译
```
    yum install protobuf-devel leveldb-devel snappy-devel opencv-devel boost-devel hdf5-devel
    yum install gflags-devel glog-devel lmdb-devel atlas-devel openblas-devel
    export OPENBLAS_NUM_THREADS=6
    make -f Makefile.centos
    cd exper
    ./run_pascal_cpu.sh

    # cmake build
    mkdir build
    cd build
    LDFLAGS=/usr/lib64/libc_nonshared.a cmake  .. -DCPU_ONLY=ON -DCMAKE_CXX_FLAGS="-I/usr/local/cuda/include" -DBLAS=open -DBOOST_LIBRARYDIR=/usr/lib64 -DGFLAGS_LIBRARY=/usr/lib64 -DPROTOBUF_LIBRARY=/usr/lib64
    make -j4
    export OPENBLAS_NUM_THREADS=6
    cd exper
    ./run_pascal_cpu.sh
```

### 脚本说明(以下脚本必须在目录exper下执行，即使用cd或pushd进入exper目录)
  1. run_pascal.sh 基于GPU方式训练并测试
  2. run_pascal_cpu.sh 基于CPU方式训练并测试
  3. run_densecrf.sh DenseCRF(密集式条件随机场)进行测试(识别)结果的细化
  4. fixlabel.sh 修复标签，不先执行该脚本，训练时将报错误“Unexpected label 220.”
  5. bin2ppm.sh 把测试(识别)结果的bin文件转换为ppm格式

