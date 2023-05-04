#!/bin/bash

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')

docker node update --label-add traefik-public.traefik-public-certificates=true $NODE_ID

export EMAIL=seu-email@gmail.com

export DOMAIN=sua-url-do-proxy

export USERNAME=admin

export PASSWORD=ffdfdjfdsf

export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)

echo $HASHED_PASSWORD

curl -L dockerswarm.rocks/traefik-host.yml -o traefik-host.yml

docker stack deploy -c traefik-host.yml traefik