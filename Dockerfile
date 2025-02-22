FROM alpine:latest

RUN mkdir -p /srv/papermc
VOLUME [ "/srv/papermc/data" ]
WORKDIR /srv/papermc

RUN apk add --no-cache alpine-conf
RUN apk add --no-cache bash
RUN apk add --no-cache openjdk21
RUN apk add --no-cache wget

RUN wget https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/175/downloads/paper-1.21.4-175.jar
RUN mv paper-1.21.4-175.jar paper.jar
RUN echo "eula=true" > eula.txt

EXPOSE 8080
EXPOSE 25565

COPY config .
COPY ops.json .
COPY plugins .
COPY server.properties .
COPY --chmod=0755 start.sh .
COPY whitelist.json .

# Download plugins
RUN mkdir -p /srv/papermc/plugins
WORKDIR /srv/papermc/plugins
RUN wget "https://hangarcdn.papermc.io/plugins/jmp/MiniMOTD/versions/2.1.5/PAPER/minimotd-bukkit-2.1.5.jar" -O MiniMOTD.jar
RUN wget "https://github.com/plan-player-analytics/Plan/releases/download/5.6.2965/Plan-5.6-build-2965.jar" -O Plan.jar
RUN wget "https://hangarcdn.papermc.io/plugins/ViaVersion/ViaVersion/versions/5.2.1/PAPER/ViaVersion-5.2.1.jar" -O ViaVersion.jar

WORKDIR /srv/papermc
ENTRYPOINT ["bash", "./start.sh"]