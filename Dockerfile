# Use the official Maven image to build the application
# This image contains Maven and JDK
FROM maven:3.8.4-openjdk-21 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the source code into the container
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK runtime image for running the application
FROM openjdk:21-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage to the current working directory
COPY --from=build /app/target/userManagement.jar ./app.jar

# Specify the command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Expose the port on which the application will run
EXPOSE 8080
