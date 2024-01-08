# Use the official OpenJDK 11 image as the base image
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Gradle build files first to leverage Docker layer caching
COPY build.gradle .
COPY settings.gradle .

# Copy the entire project to the container
COPY . .

# Download dependencies and build the project
RUN ./gradlew build -x test

# Copy the application JAR file
COPY build/libs/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run your application
CMD ["java", "-jar", "spring-boot-app.jar"]
