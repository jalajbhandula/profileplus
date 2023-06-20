# Use the Maven image to build the application
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Use the OpenJDK image as the base for the final image
FROM openjdk:17
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/webproject.jar .

# Expose the port that your Spring Boot application listens on
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "webproject.jar"]
