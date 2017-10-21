from 32bit/ubuntu:16.04
maintainer Marcel Lamm <atomy@jackinpoint.net>

ARG DOCKER_SERVER_ROOT
ARG LOCAL_USER_ID
ARG LOCAL_GROUP_ID

ENV DOCKER_SERVER_ROOT ${DOCKER_SERVER_ROOT}
ENV DOCKER_BUILT_UID ${LOCAL_USER_ID}
ENV DOCKER_BUILT_GID ${LOCAL_GROUP_ID}

RUN apt-get -y update \
	&& apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install libstdc++6 libcurl3-gnutls wget libncurses5 bzip2 unzip ncdu \
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get install -y sudo

RUN mkdir -p ${DOCKER_SERVER_ROOT}
WORKDIR ${DOCKER_SERVER_ROOT}
ENV HOME ${DOCKER_SERVER_ROOT}

# add user and group
RUN groupadd -g ${LOCAL_GROUP_ID} docker
RUN useradd -s /bin/bash -u ${LOCAL_USER_ID} -g ${LOCAL_GROUP_ID} -d ${DOCKER_SERVER_ROOT} docker

ADD ./build/docker/tf2/docker-entrypoint /usr/local/bin/docker-entrypoint
ADD ./build/env ${DOCKER_SERVER_ROOT}

# do steam stuff
RUN wget -O - http://media.steampowered.com/client/steamcmd_linux.tar.gz | tar -C ${DOCKER_SERVER_ROOT} -xvz
ADD ./build/docker/tf2/tf2_ds.txt ./build/docker/tf2/update.sh ./build/docker/tf2/startServer.sh ${DOCKER_SERVER_ROOT}

# update server files
RUN echo "Grabbing tf2 server files from steam"
RUN ${DOCKER_SERVER_ROOT}/update.sh

# fix some steam problems
RUN mkdir -p ${DOCKER_SERVER_ROOT}/.steam/sdk32
RUN ln -s ${DOCKER_SERVER_ROOT}/linux32/steamclient.so ${DOCKER_SERVER_ROOT}/.steam/sdk32/steamclient.so

RUN chown -R ${LOCAL_USER_ID}:${LOCAL_GROUP_ID} ${DOCKER_SERVER_ROOT}

# remove docker user so we can add our own one on run
RUN userdel docker

ENTRYPOINT ["docker-entrypoint"]

# game packets just need udp
EXPOSE 27015/udp

# rcon needs tcp
EXPOSE 27015/tcp

CMD ["./startServer.sh"]