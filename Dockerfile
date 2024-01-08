# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk:11-jre-hotspot

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

# Copy the application JAR file into the container at /app
COPY build/libs/guestbook-*.jar guestbook.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "guestbook.jar"]
