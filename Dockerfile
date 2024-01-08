# Use an official OpenJDK runtime as a parent image
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory to /app
WORKDIR /app

# Copy the application JAR file into the container at /app
COPY build/libs/guestbook-*.jar guestbook.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "guestbook.jar"]
