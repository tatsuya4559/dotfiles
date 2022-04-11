#!/bin/bash

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf install nodejs 16.14.2

asdf plugin add python https://github.com/danhper/asdf-python.git
asdf install python 3.9.11

asdf plugin add terraform https://github.com/Banno/asdf-hashicorp.git
asdf install terraform 1.1.5

asdf plugin add golang https://github.com/kennyp/asdf-golang.git
asdf install golang 1.18
