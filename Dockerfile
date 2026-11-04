FROM eclipse-temurin:17 AS builder
WORKDIR workspace
ARG JAR_FILE=build/libs/*.jar
COPY ${JAR_FILE} catalog-service.jar
RUN java -Djarmode=tools -jar catalog-service.jar extract
FROM eclipse-temurin:17
RUN useradd spring
USER spring
WORKDIR workspace
COPY --from=builder lib/ ./
COPY --from=builder / ./
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]