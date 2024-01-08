# Use an official OpenJDK runtime as a parent image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file from the Gradle build stage to the current working directory
COPY build/libs/*.jar app.jar

# Expose the port that the application will run on (assuming your Spring Boot app uses port 8080)
EXPOSE 8080

# Specify the command to run your Spring Boot application
CMD ["java", "-jar", "app.jar"]
