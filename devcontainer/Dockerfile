FROM golang:1.18-bullseye

RUN apt-get update && apt-get install -y \
    vim \
    stow \
    tmux \
    ripgrep \
    fzf \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
  useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME

WORKDIR /home/$USERNAME/dotfiles
RUN git clone https://github.com/tatsuya4559/dotfiles.git . && \
  git submodule update --init && \
  ./devcontainer/setup.sh

WORKDIR /home/$USERNAME/workspaces
