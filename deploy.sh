#!/bin/bash

# This is to demo

node_app=`docker ps -a | grep java-nodeapp | awk '{print $NF}'`
if [ $node_app=='java-nodeapp' ]; then
    echo "nodeapp is running, lets delete"
        docker rm -f java-nodeapp
fi

images=`docker images | grep raouagara/java-nodeapp | awk '{print $3}'`
docker rmi $images
docker run -d -p 8080:8080 --name java-nodeapp $1
