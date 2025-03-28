FROM alpine:latest

# Args
ARG PAPERMC_VERSION=1.21.4
ARG PAPERMC_BUILD=175

# Image config
EXPOSE 8080
EXPOSE 25565
VOLUME [ "/srv/papermc/worlds" ]

# Install dependencies
RUN apk add --no-cache alpine-conf
RUN apk add --no-cache bash
RUN apk add --no-cache openjdk21
RUN apk add --no-cache screen
RUN apk add --no-cache wget

# Install PaperMC
RUN mkdir -p /srv/papermc
WORKDIR /srv/papermc
RUN wget https://api.papermc.io/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${PAPERMC_BUILD}/downloads/paper-${PAPERMC_VERSION}-${PAPERMC_BUILD}.jar
RUN mv paper-${PAPERMC_VERSION}-${PAPERMC_BUILD}.jar paper.jar

# Copy server configs
# Edit or overwrite the server config files as needed
RUN mkdir -p /srv/papermc/config
COPY conf/ .

# Plugins
# Place your plugins in the plugins folder
RUN mkdir -p /srv/papermc/plugins
COPY plugins/ plugins/

# Start script
COPY --chmod=0755 start.sh .
ENTRYPOINT ["bash", "./start.sh"]