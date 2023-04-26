# OpenMLDB server image.
# Use this image to run a openmldb nameserver or tablet.

FROM debian:bullseye

# listen port
ARG PORT=9527
# If non-empty, given directory will used as openmldb release artifact (the top directory extracted from release),
# instead of downloading from release page.
ARG OPENMLDB_ART

LABEL org.opencontainers.image.source=https://github.com/aceforeverd/openmldb-docker

WORKDIR /root

ADD ${OPENMLDB_ART:-https://github.com/4paradigm/OpenMLDB/releases/download/v0.7.3/openmldb-0.7.3-linux.tar.gz} ./

RUN if [ -z ${OPENMLDB_ART} ] ; then tar xzf openmldb-*.tar.gz --strip-components=1 && rm -f openmldb-*.tar.gz; fi

ENV OPENMLDB_VER=0.7.3

EXPOSE ${PORT}

# NOTE: Must pass necessary flags, or the container will simply exit.
# Here is list of required flags (may not fully covered):
# - --port or --endpoint
# - --role
# - --zk_cluster
# - --zk_root_path
ENTRYPOINT ["./bin/openmldb" ]
