FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      software-properties-common \
      curl \
      openssh-client \
      git && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y docker-ce && \
    apt-get autoremove -y && apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NVM_SYMLINK_CURRENT true
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN /bin/bash -c "\. /root/.nvm/nvm.sh && nvm install lts/*"