FROM gradle:6.9.2-jdk11-alpine AS build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM fabric8/java-alpine-openjdk11-jdk
COPY --from=build /home/gradle/src/build/libs/*.jar /app/app-with-metrics.jar
WORKDIR /app
EXPOSE 8080
CMD ["java", "-Dspring.profiles.active=local","-jar", "app-with-metrics.jar"]
