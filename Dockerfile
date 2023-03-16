# Copyright (c) 2023 Hewlett Packard Enterprise Development LP

FROM rockylinux:9.0-minimal AS build

# Set MOFED version, OS version and platform
ARG MOFED_VER 5.9-0.5.6.0
ENV ENV_MOFED_VER=$MOFED_VER
ENV OS_VER rhel9.0
ENV PLATFORM x86_64

# Base configuration and update
RUN microdnf clean all && \
    microdnf makecache && \
    microdnf --assumeyes install epel-release kmod file findutils && \
    microdnf clean all

# Install essential tools for Mellanox OFED
RUN microdnf --assumeyes install wget perl pciutils iproute \
            tcl tk numactl-libs lsof ethtool pciutils-libs libnl3 tar.x86_64 \
            libmnl python && \
    microdnf clean all;

# Install MLNX OFED
RUN wget --quiet http://content.mellanox.com/ofed/MLNX_OFED-${MOFED_VER}/MLNX_OFED_LINUX-${ENV_MOFED_VER}-${OS_VER}-${PLATFORM}.tgz && \
    tar -xvf MLNX_OFED_LINUX-${ENV_MOFED_VER}-${OS_VER}-${PLATFORM}.tgz && \
    MLNX_OFED_LINUX-${ENV_MOFED_VER}-${OS_VER}-${PLATFORM}/mlnxofedinstall --basic --user-space-only --without-fw-update -q && \
    cd .. && \
    rm -rf MLNX_OFED_LINUX-${ENV_MOFED_VER}-${OS_VER}-${PLATFORM} && \
    rm -rf *.tgz

CMD ["/bin/bash"]
