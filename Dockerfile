# Use the official OpenJDK 11 image as the base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the Gradle files to the container
COPY build.gradle .
COPY settings.gradle .

# Copy the gradle wrapper files and download the dependencies
COPY gradlew .
COPY gradle gradle
RUN chmod +x gradlew
RUN ./gradlew dependencies

# Copy the application source code
COPY src src

# Build the application
RUN ./gradlew build

# Define the command to run your application
CMD ["java", "-jar", "spring-boot-app.jar"]
