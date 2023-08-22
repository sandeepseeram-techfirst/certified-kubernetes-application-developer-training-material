#!/bin/bash
export DEBIAN_FRONTEND="noninteractive"

#Update Packages
apt-get update

#Install Prerequisite Software
apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

#Docker GPG Key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

#Add Docker to Sources
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-cache policy docker-ce

#Install Docker
apt-get install -y docker-ce