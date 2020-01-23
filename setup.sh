#!/usr/bin/env bash

### Checking for docker, docker-compose and git as requirements
### Show a warning when requirements are not installed
which docker || echo "Please install docker on your system" & exit 1
which docker-compose || echo "Please install docker-compose on your system" & exit 1
which git || echo "Please install git on your system" & exit 1

### Cloning repositories
### Docker specifics
git clone https://github.com/nxt-engineering/hitobito-docker.git hitobito
### Hitobito Core Project
git clone https://github.com/hitobito/hitobito.git hitobito/hitobito
### Hitobito Wagon project(s)
git clone https://github.com/hitobito/hitobito_generic.git hitobito/hitobito_generic

### Running the docker containers
cd hitobito
docker-compose up app

### Output App URI(s)
echo "http://$(docker-compose port app 3000)"
echo "http://$(docker-compose port mail 1080)"

### Setting up first user account
echo 'p=Person.first; p.update(password: "password"); "You can now login as #{p.email} with the password \"password\""' | docker-compose run --rm -T app rails c