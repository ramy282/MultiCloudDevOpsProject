FROM openjdk:8-jdk-alpine

COPY build/libs/guestbook*.jar app.jar

ENTRYPOINT ["java","-Dspring.profiles.active=prod","-jar","/app.jar"]