FROM maven:3.6.0-jdk-8-slim as builder
COPY ./project /app
WORKDIR /app

RUN mvn verify

FROM openjdk:8-jre-alpine

COPY --from=builder /app/target/lavagna-jetty-console.war /app/lavagna-jetty-console.war
WORKDIR /app

ENV DB_DIALECT HSQLDB
ENV DB_URL jdbc:hsqldb:file:lavagna
ENV DB_USER sa
ENV DB_PASS ""
ENV SPRING_PROFILE dev

ENTRYPOINT java -Xms64m -Xmx128m -Ddatasource.dialect="${DB_DIALECT}" \
-Ddatasource.url="${DB_URL}" \
-Ddatasource.username="${DB_USER}" \
-Ddatasource.password="${DB_PASS}" \
-Dspring.profiles.active="${SPRING_PROFILE}" \
-jar /app/lavagna-jetty-console.war --headless