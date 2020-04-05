#FROM nvidia/opencl:runtime-ubuntu18.04
FROM nvidia/cuda:10.1-runtime-ubuntu18.04

# Env Variables for nvidia
ENV DEBIAN_FRONTEND noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=8.0"

ENV DOWNLOAD https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb
ENV CLIENT fahclient_7.5.1_amd64.deb
# just creating the doc dir for fahclient and moving supplied config.xml there as a "sample"
RUN mkdir -p /usr/share/doc/fahclient/
ADD config.xml /usr/share/doc/fahclient/sample-config.xml

# Download/Install latest FAH client
# See here for latest - https://foldingathome.org/alternative-downloads/
RUN apt-get update && apt install wget -y && wget ${DOWNLOAD} && dpkg -i --force-depends ${CLIENT} && rm fahclient*.deb

# Install Opencl 
RUN apt install ocl-icd-opencl-dev ocl-icd-libopencl1 nvidia-opencl-dev -y

# To keep down the size of the image, clean out that cache when finished installing packages.
RUN apt-get clean -y && apt-get autoclean -y && rm -rf /var/lib/apt/lists/* && apt-get autoremove -y

# EXPOSE 7396 36396

ADD config.xml /etc/fahclient/config.xml

ADD --chown=fahclient:root entrypoint.sh /home/root/
RUN chmod 751 /home/root/entrypoint.sh

ENTRYPOINT [ "/home/root/entrypoint.sh" ]
