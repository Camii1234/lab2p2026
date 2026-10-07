FROM maven:latest AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jre-jammy
WORKDIR /app
# Copia el JAR de la etapa 'build' a la etapa actual
COPY --from=build /app/target/lab2p2026.jar lab2p2026.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","lab2p2026.jar"]

