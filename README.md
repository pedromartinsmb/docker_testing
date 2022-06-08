# docker-testing

## Intro

This repository was created as a compilation of the minimal steps needed to create and run a Docker container of a Microsoft SQL Server (precisely the azure-sql-edge distribution, compatible with Apple M1 Chip).

## Concepts

**Docker**: Set of PaaS solutions that use virtualization on OS level to deliver software in packages called containers.

**Container**: Runnable instance of an image.

**Image**: Read-only template with instructions for creating a Docker container. An image can be (and often is) based on another image. Images are originally created from a Dockerfile document.

**Dockerfile**: File that describes the sequence of steps (called layers) needed to create an image. When a image is rebuilt, only the steps/layers which have changed are executed.

## Workflow

1. Create a Dockerfile like [this one](./Dockerfile).
  
2. Build an image with the following command (from the same directory as the [Dockerfile](./Dockerfile)):

        docker build -t <image_name> <path_to_dockerfile>
    
3. List existing images:

        docker images
    
4. Create a container based on the created image:

        docker create --name <container_name> <image_repository>

5. When creating a container, it is possible to set some additional options. For example, in the creation of a Apple M1 compatible SQL Server (*ish*) server (and with the Timezone manually set to America/Sao_Paulo), we must use:

        docker run -e "ACCEPT_EULA=1" -e "MSSQL_SA_PASSWORD=TestPassword123" -e "MSSQL_PID=Developer" -e "MSSQL_USER=SA" -e "TZ=America/Sao_Paulo" -p 1433:1433 -d --name=sql mcr.microsoft.com/azure-sql-edge
    
6. Once created, a (not started) container can be listed:

        docker ps -a

7. Start an existing container:

        docker start <container_name>

8. Stop a running container:

        docker stop <container_name>