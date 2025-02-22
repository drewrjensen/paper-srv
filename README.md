# paper-srv

- build: `docker build -t drewrjensen/paper-srv:$VERSION .`
-   run: `docker run --init -p 8080:8080 -p 25565:25565 -v paper-worlds-vol:/srv/papermc/worlds drewrjensen/paper-srv`