FROM ubuntu:16.04

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ARG DOCKER_COMPOSE_VERSION=1.15.0

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
      man \
      bash-completion \
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
    curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get autoremove -y && apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L https://raw.githubusercontent.com/docker/compose/master/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
RUN curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker > /etc/bash_completion.d/docker
RUN curl -L https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/bash_completion.d/git

RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN git config --global push.default simple
RUN git config --global core.eol lf

ENV NVM_SYMLINK_CURRENT true
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
RUN /bin/bash -c "\. /root/.nvm/nvm.sh && nvm install lts/*"

COPY bashrc /root/.bashrc-image
RUN echo 'if [ -f ~/.bashrc-image ]; then' >>~/.bashrc && \
    echo '    . ~/.bashrc-image' >>~/.bashrc  && \
    echo 'fi' >>~/.bashrc
