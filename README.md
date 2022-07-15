# PetClinic using Docker Compose

This project is used to demonstrate the docker build of PetClinic without using their Docker version, but their application repository.

The code builds the PetClinic application using an ephemeral Docker container and then copies the JAR from that container to the final build.  The advantage of performing this is that you don't need to install Maven on your system, or any CI servers, so the build becomes totally self contained.  The downside is that unless you add a persistent volume for the **compile** container you have to wait for the dependency download each time (but on the other hand at least you know you get all the right dependencies).

The application in this repository comes with a run time shell script that creates the application.properties file for the application when the Petclinic container launches.  This means that you can supply your Database hostname, username and passwords as variables to the container run.

This project was updated on the 15th July 2022, because of Apple's stupid idea to create their own processor, cause a lot of older containers not to work due to system call errors.  So if you're an Apple Mac user you'll find you are limited to only those container images built after 2021 from any Docker registry, but even then it's not a guarantee.  You'd be better off using a Linux system than a Mac.

## Running the project

From this directory simply do:

```bash
docker-compose up -d
```

## Rebuild an image

```bash
docker-compose build [serviceName]
```

Where service name is optional if you want to build all images again.

After rebuilding the image you'll need to **up** the system again and it will launch only the changed containers.

## Destroying everything

```bash
docker-compose down --rmi all -v
```

```bash
docker rmi maven:3.6.3-jdk-11
```

# Database container

If you're a newbie, you're probably wondering where the database container build is?

There isn't one, since there is no need to.  The SQL scripts in the **sql** directory are mapped to the special entrypoint directory provided by the MySQL and MariaDB containers, whereby if they see SQL code or shell scripts in that directory they will be actioned if the container does not find an existing database in /var/lib/mysql.  So why build a container when it provides all the details you need to just launch.