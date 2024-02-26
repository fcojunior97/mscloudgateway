FROM maven:3.9.6-eclipse-temurin-17 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

ARG EUREKA_SERVER=fco-eureka-server-latest
ARG KEYCLOAK_SERVER=fco-keycloak
ARG KEYCLOAK_PORT=8081

FROM eclipse-temurin:17
WORKDIR /app
COPY --from=build ./app/target/*.jar ./mscloudgateway.jar
ENTRYPOINT java -jar mscloudgateway.jar