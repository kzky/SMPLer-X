ARG TAG=11.3.1-cudnn8-devel-ubuntu20.04

FROM nvidia/cuda:${TAG}

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

RUN apt-get update

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update  \
    && apt-get install -y wget \
        git \
        python3.8 \
        python3.8-venv \
        python3.8-dev \
        python3-pip \
        less \
        build-essential \
        gfortran \
        libibverbs-dev \
        ca-certificates \
        bzip2 \
        ca-certificates \
        curl \
        libgl1-mesa-glx \
        openssh-client \
        zip \
        libxi6 \
        libglib2.0-0 \
        ffmpeg \
        libcairo2 \
        libcairo2-dev \
        libglfw3-dev \
        libgles2-mesa-dev

RUN pip3 install -U pip

# 1. Follow README instruction for python dependencies
# 2. Better to download models from https://huggingface.co/camenduru/SMPLer-X/tree/main