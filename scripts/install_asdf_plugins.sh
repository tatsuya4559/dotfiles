#!/bin/bash
asdf plugin add nodejs
asdf install nodejs latest

asdf plugin add python
asdf install python latest

asdf plugin add golang
asdf install golang latest

asdf plugin add terraform
asdf install terraform latest

asdf plugin add tflint
asdf install tflint latest

asdf plugin add awscli
asdf install awscli latest
asdf global awscli latest

asdf plugin add shfmt
asdf install shfmt latest
asdf global shfmt latest

asdf plugin add shellcheck
asdf install shellcheck latest
asdf global shellcheck latest
