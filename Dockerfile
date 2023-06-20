#
# Build stage
#
FROM maven:3.8.4-jdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

#
# Package stage
#
FROM openjdk:17-jdk-slim
COPY --from=build /target/webproject-0.0.1-SNAPSHOT.jar webproject.jar
# ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["java","-jar","webproject.jar"]