# joshrivers/development-shell

A Docker image which provides a development environment inside a container with a number of utility packages installed:

- Docker
- NVM / Node Stable
- SSH
- Git

Provisions are made to bring in several external directories to enable full workflows from within the container.

- SSH Config
- npmrc

## Usage

Create a script or alias which performs the following:

     docker run \
       --rm \
       -ti \
       --volume $(pwd):/usr/src/app \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       joshrivers/development-shell