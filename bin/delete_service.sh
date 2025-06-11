#!/bin/bash

check_docker_installed() {
    if ! command -v docker &> /dev/null; then
        echo "Docker is not installed or not running."
        exit 1
    fi
}

check_docker_running() {
    if ! docker info > /dev/null 2>&1; then
        echo "Docker is not running."
        exit 1
    fi
}

check_docker_compose_installed() {
    if ! command -v docker compose &> /dev/null; then
        echo "Docker Compose is not installed."
        exit 1
    fi
}

checking_running_containers_and_images() {
    local project_name="$1"

    if check_docker_compose_installed; then
        local running_containers=$(docker compose -p $project_name ps -q)
        if [ -n "$running_containers" ]; then
            echo "There are running containers for the project '$project_name'."
            docker compose -p $project_name ps
        else
            echo "No running containers found for the project '$project_name'."
        fi
    else
        local running_containers=$(docker ps -q --filter "name=$project_name")
        if [ -n "$running_containers" ]; then
            echo "There are running containers for the service '$project_name'."
            docker ps --filter "name=$project_name"
        else
            echo "No running containers found for the service '$project_name'."
        fi
    fi

    # Check for images
    local images=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$project_name")
    if [ -n "$images" ]; then
        echo "Images associated with the service '$project_name':"
        echo "$images"
    else
        echo "No images found for the service '$project_name'."
    fi
}

remove_docker_compose_project() {
    local project_name="$1"

    if check_docker_compose_installed; then
        echo "Removing Docker Compose project '$project_name'..."
        docker compose -p "$project_name" down --remove-orphans
    else
        echo "Docker Compose is not installed. Skipping project removal."
    fi

    #Remove any associated volumes
    local volumes=$(docker volume ls --filter "name=$project_name" -q)
    if [ -n "$volumes" ]; then
        echo "Removing volumes associated with the project '$project_name'..."
        docker volume rm $volumes
    else
        echo "No volumes found for the project '$project_name'."
    fi

    #Remove any associated networks
    local networks=$(docker network ls --filter "name=$project_name" -q)
    if [ -n "$networks" ]; then
        echo "Removing networks associated with the project '$project_name'..."
        docker network rm $networks
    else
        echo "No networks found for the project '$project_name'."
    fi

    #Remove any associated images
    docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | grep "$project_name") 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "No images found for the project '$project_name' or they are in use."
    fi

    echo "Docker Compose project '$project_name' removed successfully."
}

main() {
    check_docker_installed
    check_docker_running
    check_docker_compose_installed

    checking_running_containers_and_images "playwright"
    remove_docker_compose_project "playwright"
}
main "$@"
# End of script