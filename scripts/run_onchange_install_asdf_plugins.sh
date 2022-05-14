#!/bin/bash

asdf plugin add nodejs
asdf install nodejs 16.14.2

asdf plugin add python
asdf install python 3.9.11

asdf plugin add golang
asdf install golang 1.18
asdf global golang 1.18

asdf plugin add terraform
asdf install terraform 1.1.5

asdf plugin add tflint
asdf install tflint latest

asdf plugin add awscli
asdf install awscli 2.5.4
asdf global awscli 2.5.4

asdf plugin add heroku-cli
asdf install heroku-cli 7.60.1
asdf global heroku-cli 7.60.1

asdf plugin add shfmt
asdf install shfmt latest
asdf global shfmt latest

asdf plugin add shellcheck
asdf install shellcheck latest
asdf global shellcheck latest
