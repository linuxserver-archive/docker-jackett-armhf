FROM lsiobase/xenial.armhf
MAINTAINER sparklyballs

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV XDG_DATA_HOME="/config" \
XDG_CONFIG_HOME="/config"

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	bzip2 \
	libcurl4-openssl-dev \
	libmono-cil-dev \
	wget && \

# install Jackett
 mkdir -p \
	/app/Jackett && \
 jack_tag=$(curl -sX GET  "https://api.github.com/repos/Jackett/Jackett/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
 /tmp/jacket.tar.gz -L \
	https://github.com/Jackett/Jackett/releases/download/$jack_tag/Jackett.Binaries.Mono.tar.gz && \
 tar xf \
 /tmp/jacket.tar.gz -C \
	/app/Jackett --strip-components=1 && \

# cleanup
 apt-get clean && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/* 

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /downloads
EXPOSE 9117
