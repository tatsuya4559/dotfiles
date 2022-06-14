FROM ubuntu:20.04

RUN apt update && apt install -y sudo git curl

# add user
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME

# setup environment
COPY --chown=$USERNAME:$GROUPNAME . /home/$USERNAME/dotfiles
WORKDIR /home/$USERNAME/dotfiles
RUN bash -x yadf deploy
# RUN cd ./plug && make install

CMD ["bash"]

