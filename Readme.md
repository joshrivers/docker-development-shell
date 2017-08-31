# joshrivers/development-shell

A Docker image which provides a development environment inside a container with a number of utility packages installed:

- Docker
- docker-compose
- NVM / Node Stable
- SSH
- Git
- AWS CLI
- AWS ADFS client
- Silver Searcher (ag)
- man (for reading git cli help)

Provisions are made to run a volume-mounted script file for environment detection and configuration of external credentials into the container.

## Usage

Create a script or alias which performs the following:

     docker run \
       --rm \
       -ti \
       --volume $(pwd):/usr/src/app \
       --volume /var/run/docker.sock:/var/run/docker.sock \
       joshrivers/development-shell

CMD Script to mount local directory:

     cmd /c "docker run --rm -ti -v %cd%:/usr/src/app -v /var/run/docker.sock:/var/run/docker.sock joshrivers/development-shell /bin/bash"