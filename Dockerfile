FROM ubuntu:16.04

RUN apt-get update -y && apt-get install -y \
    bc \
    bzip2 \
    curl \
    g++ \
    git \
    less \
    libbz2-dev \
    libcurl4-openssl-dev \
    liblzma-dev \
    libncurses-dev \
    libssl-dev \
    libtbb-dev \
    littler \
    make \
    man \
    openjdk-8-jre \
    parallel \
    perl \
    r-base-dev \
    time \
    unzip \
    vim \
    wget \
    zlib1g-dev \
    libmysqlclient-dev \
    python3-pip

# Install Python 3.6
RUN wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz && tar -xvf Python-3.6.3.tgz
WORKDIR Python-3.6.3
RUN ./configure
RUN make
RUN make install

# installing python libraries
RUN pip3 install click==7.0

# download tools
WORKDIR /usr/local/bin
COPY downloads.sh .
RUN . downloads.sh

# set path
ENV PATH=/usr/local/bin/scripts:$PATH

# supporting UTF-8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# wrapper
COPY scripts/ .
RUN chmod +x run*.sh

# default command
CMD ["ls","/usr/local/bin/"]
