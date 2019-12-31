FROM maven:3.6.0-jdk-8-slim as builder
COPY ./project /app
WORKDIR /app

RUN mvn verify

FROM maven:3.6.0-jdk-8-slim

COPY --from=builder /app/target/lavagna-jetty-console.war /app/lavagna-jetty-console.war
COPY ep.sh /app/ep.sh

WORKDIR /app

ENV DB_DIALECT MYSQL
ENV DB_URL jdbc:mysql//mysql:3306/lavagna
ENV DB_USER root
ENV DB_PASS pass
ENV SPRING_PROFILE prod

ENTRYPOINT ep.sh