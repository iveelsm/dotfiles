#!/usr/bin/env bash

# Clone the repo

sudo git clone https://github.com/asdf-vm/asdf.git /opt/asdf/
(cd asdf && chmod +x asdf.sh)

# Java
asdf plugin add java
asdf install java adoptopenjdk-14.0.2+12  
asdf install java adoptopenjdk-11.0.8+10  
asdf install java adoptopenjdk-8.0.272+10  

# Erlang
asdf plugin add erlang
asdf install erlang latest

# Golang
asdf plugin add golang
asdf install golang latest

# Terraform
asdf plugin add terraform
asdf install terraform 0.12.9
asdf install terraform 0.13.2

# Groovy
asdf plugin add groovy
asdf install groovy 2.4.6
asdf install groovy 3.0.6

# Scala
asdf plugin add scala
asdf install scala latest

# Ruby
asdf plugin add ruby
asdf install ruby 2.5.1
asdf install ruby 2.7.0
asdf install ruby 2.7.2

# Nodejs
asdf plugin add nodejs
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-previous-release-team-keyring'
asdf install nodejs 10.15.1
asdf install nodejs 8.9.1
asdf install nodjes 12.18.2

# Set default versions
asdf global nodejs 12.18.2
asdf global ruby 2.7.2
asdf global scala latest
asdf global groovy 3.0.6
asdf global terraform 0.13.2
asdf global golang latest
asdf global erlang latest
asdf global java adoptopenjdk-14.0.2+12  