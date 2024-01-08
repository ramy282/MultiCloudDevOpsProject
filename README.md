# About

A simple guestbook webapp written in java using [Spring Boot](https://spring.io/projects/spring-boot).

# Run

* In dev environment: `gradle bootRun`
* In prod environment: Create runnable jar (see [Build](#Build)), and start it with `java -Dspring.profiles.active=prod -jar app.jar`

# Build

Following procedure describes how to build a Docker Image and push it to the [registry](https://gitlab.com/mn94/guestbook/container_registry).

*Assuming you're working directory is the project root.*

1. Build Runnable Jar: `gradle bootJar`
2. Build Docker Image: `docker build -t registry.gitlab.com/mn94/guestbook:latest .`
3. (optional) Login to Registry: `docker login registry.gitlab.com`
4. Push to Registry: `docker push registry.gitlab.com/mn94/guestbook:latest`

# Database

* The schema DDL can be found in the project root `schema.sql`.
* To regenerate the `schema.sql` based on the JPA entities follow [this](https://stackoverflow.com/questions/36966337/how-to-generate-a-ddl-creation-script-with-a-modern-spring-boot-data-jpa-and-h) approach.

# Setup Application Stack

Before deploying the webapp, the application stack needs to be setup properly. This is meant to be a unique task (per deployment system), which includes setting up a [docker network](https://docs.docker.com/network/), a [MySQL container](https://hub.docker.com/_/mysql), an inspector container as well as creating the initial schema.

1. Create Network: `docker network create --driver=bridge guestbook`
2. Run MySQL Container: `docker run --name guestbook_db -v guestbook_db:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=guestbook --network guestbook -d mysql:5.7`
3. Run inspection container: `docker run -dit --name guestbook_inspector --network guestbook alpine ash`
4. Copy schema to inspection container: `docker cp schema.sql guestbook_inspector:/tmp/schema.sql` (assuming `schema.sql` is in your current working directory)
5. Connect to inspection container: `docker container attach guestbook_inspector`
6. Install mysql client and curl: `apk update && apk upgrade && apk add mysql-client curl`
7. Import schema to MySQL DB: `mysql -h guestbook_db -u root -p guestbook < /tmp/schema.sql`
8. Disconnect from inspection container: `CTRL+P CTRL+Q`

# Deploy

Following procedure describes how to deploy the guestbook webapp using docker. The same procedure applies when deploying new versions of the app. 

*Make sure the application stack has been [setup](#setup-application-stack) and the Docker Image has been [built](#Build).*

1. Delete old container (if exists): `docker container stop guestbook && docker container rm guestbook || true`
2. (optional) Login to Registry: `docker login registry.gitlab.com`
3. Pull latest image: `docker pull registry.gitlab.com/mn94/guestbook:latest`
4. Run container (on port 80 of host): `docker run -d -p 80:8080 --name guestbook --network guestbook registry.gitlab.com/mn94/guestbook:latest`