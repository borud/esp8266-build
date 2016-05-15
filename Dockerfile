FROM ubuntu:14.04

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
    autoconf automake bash bison build-essential flex g++ gawk gcc git \
    gperf gperf libc6-dev-i386 libexpat-dev libncurses5-dev libtool \
    make ncurses-dev python python-serial screen sed sudo texinfo \
    unzip emacs wget

### Add the builder user
#
RUN useradd -d /home/builder -m -s /bin/bash builder
RUN echo "builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/builder
RUN chmod 0440 /etc/sudoers.d/builder

### Build compiler and SDK
#
RUN su builder -c "git clone --recursive https://github.com/pfalcon/esp-open-sdk.git /home/builder/esp-open-sdk"
RUN su builder -c "cd /home/builder/esp-open-sdk && make STANDALONE=y"

ENV PATH /home/builder/esp-open-sdk/xtensa-lx106-elf/bin:$PATH
RUN echo $PATH
