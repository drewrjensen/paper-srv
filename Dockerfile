FROM alpine:latest

WORKDIR /srv/papermc

RUN apk add --no-cache alpine-conf
RUN apk add --no-cache openjdk21
RUN apk add --no-cache wget

RUN wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/175/downloads/paper-1.21.4-175.jar
RUN mv paper-1.21.4-175.jar paper.jar
RUN echo "eula=true" > eula.txt

VOLUME [ "/srv/papermc/data" ]
EXPOSE 25565

COPY config .
COPY ops.json .
COPY server.properties .
COPY --chmod=0755 start.sh .
COPY whitelist.json .

ENTRYPOINT ["/srv/papermc/start.sh"]