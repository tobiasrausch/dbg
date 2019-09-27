# use the ubuntu base image
FROM ubuntu:18.04

MAINTAINER Tobias Rausch rausch@embl.de

# install required packages
# Install packages
RUN apt-get update && apt-get install -y \
    build-essential \
    g++ cmake \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    python \
    xemacs21 \
    git \
    libncurses5-dev \
    libcurl4-openssl-dev \
    wget \
    screen \
    nfs-common \
    dnsmasq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# install htslib
RUN cd /opt \
    && git clone https://github.com/samtools/htslib.git \
    && cd /opt/htslib \
    && make \
    && make lib-static \
    && make install

# install samtools
RUN cd /opt \
    && git clone https://github.com/samtools/samtools.git \
    && cd /opt/samtools \
    && make \
    && make install

# install bcftools
RUN cd /opt \
    && git clone https://github.com/samtools/bcftools.git \
    && cd /opt/bcftools \
    && make \
    && make install

# install lighter
RUN cd /opt \
    && git clone https://github.com/mourisl/Lighter.git \
    && cd Lighter \
    && git checkout v1.1.2 \
    && make \
    && install -p lighter /usr/local/bin

# install bcalm
RUN cd /opt \
    && git clone --recursive https://github.com/GATB/bcalm.git \
    && cd bcalm \
    && mkdir build \
    && cd build \
    && cmake -DKSIZE_LIST="32 64" .. \
    && make -j 8 \
    && install -p bcalm /usr/local/bin

# install bifrost
RUN cd /opt \
    && git clone --recursive https://github.com/pmelsted/bifrost.git \
    && cd bifrost \
    && mkdir build \
    && cd build \
    && sed -i "s/MAX_KMER_SIZE \"32\"/MAX_KMER_SIZE \"64\"/" ../CMakeLists.txt \
    && cmake .. \
    && make \
    && make install


# by default /bin/sh is executed
CMD ["/bin/sh"]
