FROM ubuntu:16.04

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      apt-transport-https \
      build-essential \
      ca-certificates \
      software-properties-common \
      net-tools \
      iputils-ping \
      curl \
      vim \
      silversearcher-ag \
      openssh-client \
      git && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
      less \
      groff \
      python2.7 python-pip && \
    pip install awscli && \
    pip install aws-adfs && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y docker-ce && \
    apt-get autoremove -y && apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker > /etc/bash_completion.d/docker
COPY bashrc /root/.bashrc-image
RUN echo 'if [ -f ~/.bashrc-image ]; then' >>~/.bashrc && \
    echo '    . ~/.bashrc-image' >>~/.bashrc  && \
    echo 'fi' >>~/.bashrc

ENV NVM_SYMLINK_CURRENT true
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN /bin/bash -c "\. /root/.nvm/nvm.sh && nvm install lts/*"