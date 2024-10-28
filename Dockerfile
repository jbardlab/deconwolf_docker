# Base image with CUDA 12.3.2, and Ubuntu 22.04
FROM nvidia/cuda:12.3.2-devel-ubuntu22.04

# Set environment variables to avoid interactive installations
ENV DEBIAN_FRONTEND=noninteractive

# these dependencies suggested by: https://github.com/elgw/deconwolf/blob/master/INSTALL.md
# Install the required dependencies for deconwolf
RUN apt-get update && \
    apt-get install -y \
        cmake \
        pkg-config \
        gcc \
        libfftw3-single3 \
        libfftw3-dev \
        libgsl-dev \
        libomp-dev \
        libpng-dev \
        libtiff-dev && \
    rm -rf /var/lib/apt/lists/*

# install other dependencies (not from deconwolf git page manual)
RUN apt-get update && \
    apt-get install -y \
    git \
    file \
    ocl-icd-opencl-dev \
    opencl-headers \
    clinfo \
    && \
    rm -rf /var/lib/apt/lists/*

# Clone the deconwolf repository
RUN mkdir /deconwolf && \
    cd /deconwolf && \
    git clone --depth 1 --branch v0.4.3 https://github.com/elgw/deconwolf.git .

# Build deconwolf
RUN mkdir /deconwolf/builddir && \
    cd /deconwolf/builddir && \
    cmake .. && \
    cmake --build .

# Optional: Clean up build dependencies to reduce image size
# RUN apt-get remove -y \
#         cmake \
#         pkg-config \
#         gcc \
#         libfftw3-dev \
#         libgsl-dev \
#         libomp-dev \
#         libpng-dev \
#         libtiff-dev && \
#     apt-get autoremove -y && \
#     apt-get clean && \
#     rm -rf /deconwolf /var/lib/apt/lists/*

# Set entrypoint if needed
# ENTRYPOINT ["/bin/bash"]
