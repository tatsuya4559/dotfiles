FROM ubuntu:20.04

RUN apt update && apt install -y sudo git curl
RUN sh -c "$(curl -fsLS chezmoi.io/get)" -- init --apply tatsuya4559

CMD ["bash"]

