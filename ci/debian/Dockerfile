FROM debian:bookworm

# Add deb-src to sources.list
RUN find /etc/apt/sources.list* -type f -exec sed -i 'p; s/^deb /deb-src /' '{}' +

# Install developer tools
RUN apt-get update \
 && apt-get install --no-install-recommends -yV build-essential devscripts \
    equivs wget git zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev \
    libsqlite3-dev libreadline-dev libffi-dev curl libbz2-dev cmake ninja-build \
    openssh-client pkg-config liblzma-dev python3-pip

RUN export OPENCV_VERSION=4.5.4 \
    && git clone https://github.com/opencv/opencv.git --branch $OPENCV_VERSION \
    && cd opencv \
    && git clone https://github.com/opencv/opencv_contrib --branch $OPENCV_VERSION \
    && mkdir build \
    && cd build \
    && cmake\
        -DCMAKE_INSTALL_PREFIX=/usr\
        -DCMAKE_BUILD_TYPE=None\
        -DCMAKE_INSTALL_SYSCONFDIR=/etc\
        -DCMAKE_INSTALL_LOCALSTATEDIR=/var\
        -DCMAKE_EXPORT_NO_PACKAGE_REGISTRY=ON\
        -DCMAKE_FIND_PACKAGE_NO_PACKAGE_REGISTRY=ON\
        "-GUnix Makefiles"\
        -DCMAKE_VERBOSE_MAKEFILE=ON\
        -DCMAKE_INSTALL_LIBDIR=lib/x86_64-linux-gnu\
        -GNinja\
        -DANT_EXECUTABLE=/usr/bin/ant\
        -DBUILD_EXAMPLES=OFF\
        -DBUILD_PROTOBUF=ON\
        -DBUILD_PERF_TESTS=OFF\
        -DBUILD_opencv_dnn=ON\
        -DBUILD_opencv_dnn_modern=ON\
        -DBUILD_opencv_face=ON\
        -DBUILD_opencv_objdetect=ON\
        -DCMAKE_BUILD_TYPE=Release\
        "-DCMAKE_CXX_FLAGS_RELEASE=-g -O2\
        -fdebug-prefix-map=/w/opencv-debian=.  -fstack-protector-strong -Wformat -Werror=format-security" \
        "-DCMAKE_C_FLAGS_RELEASE=-g -O2 -fdebug-prefix-map=/w/opencv-debian=.  -fstack-protector-strong -Wformat -Werror=format-security" \
        "-DCMAKE_EXE_LINKER_FLAGS_RELEASE=-Wl,-z,relro -Wl,-z,now"\
        -DCMAKE_INSTALL_LIBDIR=lib/x86_64-linux-gnu\
        -DCMAKE_INSTALL_PREFIX=/usr\
        -DCMAKE_SKIP_RPATH=ON\
        -DCMAKE_VERBOSE_MAKEFILE=ON\
        -DENABLE_PRECOMPILED_HEADERS=OFF\
        -DINSTALL_C_EXAMPLES=ON\
        -DINSTALL_PYTHON_EXAMPLES=ON\
        -DOPENCL_INCLUDE_DIR:PATH=/usr/include/CL/\
        -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules\
        -DOPENCV_MATHJAX_RELPATH=/usr/share/javascript/mathjax/\
        -DOPENCV_SKIP_PYTHON_LOADER=ON\
        -DOPENCV_GENERATE_PKGCONFIG=ON\
        -DOPENCV_LAPACK_FIND_PACKAGE_ONLY=ON\
        -DOpenGL_GL_PREFERENCE=GLVND\
        -DPROTOBUF_UPDATE_FILES=OFF\
        -DWITH_ADE=OFF\
        -DWITH_CAROTENE=OFF\
        -DWITH_CUDA=OFF\
        -DWITH_EIGEN=OFF\
        -DWITH_FFMPEG=OFF\
        -DWITH_GDAL=OFF\
        -DWITH_GDCM=OFF\
        -DWITH_GSTREAMER=OFF\
        -DWITH_GPHOTO2=OFF\
        -DWITH_GTK=OFF\
        -DWITH_IPP=OFF\
        -DWITH_ITT=OFF\
        -DWITH_JASPER=OFF\
        -DWITH_JPEG=OFF\
        -DWITH_WEBP=OFF \
        -DWITH_LAPACK=OFF\
        -DWITH_NGRAPH=OFF\
        -DWITH_OPENCL=OFF\
        -DWITH_OPENEXR=OFF\
        -DWITH_OPENGL=OFF\
        -DWITH_PNG=OFF\
        -DWITH_PVAPI=OFF\
        -DWITH_QT=OFF\
        -DWITH_QUIRC=OFF\
        -DWITH_TIFF=OFF\
        -DWITH_UNICAP=OFF\
        -DWITH_VTK=OFF\
        -DWITH_XINE=OFF\
        -DCPU_BASELINE=SSE2\
        -DCPU_BASELINE_DISABLE=SSE3\
        -DWITH_TBB=OFF\
        -DWITH_1394=OFF\
        -DWITH_V4L=OFF\
        -DBUILD_SHARED_LIBS=OFF\
        -DBUILD_DOCS=OFF\
        -DBUILD_TESTS=OFF\
        ..\
    && ninja install \
    && echo "==> Hacking openCV PC file to make linking statically working" \
    && sed -i "s/-lIconv::Iconv//g" /usr/lib/x86_64-linux-gnu/pkgconfig/opencv4.pc \
    && pkg-config --list-all
