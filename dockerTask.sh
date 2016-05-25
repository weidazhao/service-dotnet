imageName="weidazhao/service-dotnet"
publicPort=5000
isWebProject=true

# .net core runtime ID for the container (used to publish the app correctly)
RuntimeID="debian.8-x64"
# .net core framework (used to publish the app correctly)
Framework="netcoreapp1.0"

# Kills all running containers of an image and then removes them.
cleanAll () {
    # List all running containers that use $imageName, kill them and then remove them.
    docker kill $(docker ps -a | awk '{ print $1,$2 }' | grep $imageName | awk '{ print $1}') > /dev/null 2>&1;
    docker rm $(docker ps -a | awk '{ print $1,$2 }' | grep $imageName | awk '{ print $1}') > /dev/null 2>&1;

    if [[ -d "./bin" ]]; then
        rm -f -r "./bin"
    fi
}

# Builds the Docker image.
buildImage () {
    if [[ -z $ENVIRONMENT ]]; then
       ENVIRONMENT="debug"
    fi

    dockerFileName="Dockerfile.$ENVIRONMENT"
    pubPath="./bin/Docker/$ENVIRONMENT/app"
    pubDockerFilePath="$pubPath/$dockerFileName"

    if [[ ! -f $dockerFileName ]]; then
      echo "$ENVIRONMENT is not a valid parameter. File '$dockerFileName' does not exist." 
    else
      echo "Publishing the project"
      dotnet publish -f $Framework -r $RuntimeID -c $ENVIRONMENT -o $pubPath .

      echo "Building the image $imageName ($ENVIRONMENT)."
      docker build -f $pubDockerFilePath -t $imageName $pubPath

      tag="$(date +'%Y-%m-%d_%H-%M-%S')"
      docker tag $imageName "$imageName:$tag"
    fi
}

# Builds the Docker image.
buildImage2 () {
  echo "Building the image $imageName ($ENVIRONMENT)."
  docker build -t $imageName:latest .
  docker push $imageName:latest
}

# Runs docker-compose.
compose () {
  if [[ -z $ENVIRONMENT ]]; then
    ENVIRONMENT="debug"
  fi

  composeFileName="docker-compose.$ENVIRONMENT.yml"

  if [[ ! -f $composeFileName ]]; then
    echo "$ENVIRONMENT is not a valid parameter. File '$composeFileName' does not exist." 
  else
    echo "Running compose file $composeFileName"
    docker-compose -f $composeFileName kill
    
    if [[ $ENVIRONMENT = "release" ]]; then
      docker-compose -f $composeFileName build
    fi

    docker-compose -f $composeFileName up -d

    if [[ $isWebProject = true ]]; then
      openSite
    fi
  fi
}

openSite () {
    printf 'Opening site'
    until $(curl --output /dev/null --silent --head --fail http://$(docker-machine ip $(docker-machine active)):$publicPort); do
      printf '.'
      sleep 1
    done

    # Open the site.
    start "http://$(docker-machine ip $(docker-machine active)):$publicPort"
}

# Shows the usage for the script.
showUsage () {
    echo "Usage: dockerTask.sh [COMMAND] (ENVIRONMENT)"
    echo "    Runs build or compose using specific environment (if not provided, debug environment is used)"
    echo ""
    echo "Commands:"
    echo "    build: Builds a Docker image ('$imageName')."
    echo "    compose: Builds the images and runs docker-compose. Images are re-built when using release environment, while debug environment uses a cached version of the image."
    echo "    clean: Removes the image '$imageName' and kills all containers based on that image."
    echo ""
    echo "Environments:"
    echo "    debug: Uses debug environment for build and/or compose."
    echo "    release: Uses release environment for build and/or compose."
    echo ""
    echo "Example:"
    echo "    ./dockerTask.sh build debug"
    echo ""
    echo "    This will:"
    echo "        Build a Docker image named $imageName using debug environment."
}

if [ $# -eq 0 ]; then
  showUsage
else
  case "$1" in
      "compose")
             ENVIRONMENT=$2
             compose
             ;;
      "build")
             ENVIRONMENT=$2
             buildImage
             ;;
      "build2")
             ENVIRONMENT=$2
             buildImage2
             ;;
      "clean")
             cleanAll
             ;;
      *)
             showUsage
             ;;
  esac
fi