# Define variables
$IMAGE="ghcr.io/shalimov-as/jupyter:gpu-python3.10-tf2.13.0"
$PROJECT_DIRNAME = Split-Path -Leaf -Path $args[0]
$NAME="jupyter_"+$PROJECT_DIRNAME
$SCRIPTPATH= Split-Path $MyInvocation.MyCommand.Path
$WD= Resolve-Path $args[0]
$PREPARE_SH_PATH= Join-Path $SCRIPTPATH "prepare.sh"

# Pull the Docker image
docker pull $IMAGE
# Stop any running container with the same name
docker stop $NAME
# Run the Docker container
docker run `
    --gpus=all `
    --rm `
    --name=$NAME `
    --user root `
    --shm-size=6gb `
    --rm `
    -d  `
    -p 8888:8888 `
    -p 6006:6006 `
    -e NB_UID=$(id -u) `
    -e NB_GID=$(id -g) `
    -e DOCKER_STACKS_JUPYTER_CMD="notebook" `
    -e PROJECT_DIRNAME="$PROJECT_DIRNAME" `
    -v ${WD}:/home/jovyan/work `
    -v ${PREPARE_SH_PATH}:/usr/local/bin/before-notebook.d/prepare.sh `
    $IMAGE
