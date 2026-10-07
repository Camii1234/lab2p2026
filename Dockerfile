FROM maven:3.9.16-eclipse-temurin-17 AS build
WORKDIR /app

COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN chmod +x mvnw \
    && ./mvnw -B --no-transfer-progress dependency:go-offline

COPY src/ src/
RUN ./mvnw -B --no-transfer-progress package -DskipTests \
    && test -f target/lab2p2026.jar

FROM eclipse-temurin:17-jre-jammy
RUN groupadd --system --gid 10001 app \
    && useradd --system --uid 10001 --gid app --no-create-home --shell /usr/sbin/nologin app
WORKDIR /app
COPY --from=build --chown=app:app /app/target/lab2p2026.jar lab2p2026.jar
USER app
EXPOSE 8080
ENTRYPOINT ["java","-jar","lab2p2026.jar"]
