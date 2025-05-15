FROM eclipse-temurin:21 AS build

RUN apt-get update
RUN apt-get install unzip make -y

ARG VERSION=1.6.4
RUN wget https://repo.e-hentai.org/hath/HentaiAtHome_${VERSION}_src.zip -O /tmp/hath.zip
RUN unzip /tmp/hath.zip -d /tmp/hath
WORKDIR /tmp/hath
RUN make
WORKDIR /tmp/hath/build
# Sourced from hath.zip/makejar.sh
RUN jar cvfm HentaiAtHome.jar ../src/hath/base/HentaiAtHome.manifest hath/base

FROM alpine:3 AS runtime
WORKDIR /app/data/
RUN apk add openjdk21-jre

COPY --from=build /tmp/hath/build/HentaiAtHome.jar /app/HentaiAtHome.jar
ENTRYPOINT [ "java", "-jar", "/app/HentaiAtHome.jar" ]