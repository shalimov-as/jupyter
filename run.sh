#!/bin/bash

IMAGE="path/jupyter/cv:gpu-python3.10-tf2.13.0"
PROJECT_DIRNAME=$(basename $1)
NAME="jupyter_"${PROJECT_DIRNAME}
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
WD="${SCRIPTPATH}/../${PROJECT_DIRNAME}"

# docker pull ${IMAGE}
docker stop ${NAME}
docker run \
    --runtime=nvidia \
    --rm \
    --network=host \
    --name=$NAME \
    --user root \
    --shm-size=6gb \
    --rm \
    -d \
    -p 8888:8888 \
    -p 6006:6006 \
    -e NB_UID=$(id -u) \
    -e NB_GID=$(id -g) \
    -e DOCKER_STACKS_JUPYTER_CMD="notebook" \
    -e PROJECT_DIRNAME="${PROJECT_DIRNAME}" \
    -v ${WD}:/home/jovyan/work \
    -v ${SCRIPTPATH}/prepare.sh:/usr/local/bin/before-notebook.d/prepare.sh \
    ${IMAGE}
sleep 5
docker logs ${NAME}
