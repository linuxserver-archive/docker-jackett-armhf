[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/Jackett/Jackett
[hub]: https://hub.docker.com/r/lsioarmhf/jackett/

THIS IMAGE IS DEPRECATED. PLEASE USE THE MULTI-ARCH IMAGES AT `linuxserver/jackett`

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# lsioarmhf/jackett
[![](https://images.microbadger.com/badges/version/lsioarmhf/jackett.svg)](https://microbadger.com/images/lsioarmhf/jackett "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/lsioarmhf/jackett.svg)](https://microbadger.com/images/lsioarmhf/jackett "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/lsioarmhf/jackett.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/lsioarmhf/jackett.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/armhf/armhf-jackett)](https://ci.linuxserver.io/job/Docker-Builders/job/armhf/job/armhf-jackett/)

Jackett works as a proxy server: it translates queries from apps (Sonarr, SickRage, CouchPotato, Mylar, etc) into tracker-site-specific http queries, parses the html response, then sends results back to the requesting software. This allows for getting recent uploads (like RSS) and performing searches. Jackett is a single repository of maintained indexer scraping & translation logic - removing the burden from other apps.[Jackett](https://github.com/Jackett/Jackett)

[![jackett](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/jackett-banner.png)][appurl]

## Usage

```
docker create --name=jackett \
-v <path to data>:/config \
-v <path to blackhole>:/downloads \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 9117:9117 \
lsioarmhf/jackett
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 9117` - the port(s)
* `-v /config` - where Jackett should store its config file.
* `-v /downloads` - Path to torrent blackhole
* `-e RUN_OPTS` - Optionally specify additional arguments to be passed. EG. `--ProxyConnection=10.0.0.100:1234`
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone EG. Europe/London

It is based on ubuntu xenial with s6 overlay, for shell access whilst the container is running do `docker exec -it jackett /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application
`IMPORTANT... THIS IS THE ARMHF VERSION`

The web interface is at `<your-ip>:9117` , configure various trackers and connections to other apps there.
More info at [Jackett](https://github.com/Jackett/Jackett).


## Info

* To monitor the logs of the container in realtime `docker logs -f jackett`.

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' jackett`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' lsioarmhf/jackett`

## Versions

+ **19.01.19:** This image is deprecated. Please use the multi-arch images at linuxserver/jackett
+ **11.06.18:** Ensure root ownership of Jackett files.
+ **09.02.18:** Add --NoUpdates flag.
+ **26.01.18:** Fix continuation lines.
+ **19.04.17:** Switch to using inhouse mono baseimage, ubuntu xenial based.
+ **14.10.16:** Add version layer information.
+ **22.09.16:** Initial Release.
