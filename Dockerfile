FROM alpine:3.9
ARG VERSION
ARG VCS_REF
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.version="$VERSION" \
      org.label-schema.maintainer="https://github.com/capybara1/" \
      org.label-schema.url="https://github.com/capybara1/Docker-Docker" \
      org.label-schema.name="docker" \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-url="https://github.com/capybara1/Docker-Docker" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.dockerfile="/Dockerfile"
ENV DOCKER_VERSION 17.09.0-ce
RUN apk --no-cache add bash curl \
 && cd /tmp/ \
 && curl -sSL -O https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
 && tar zxf docker-${DOCKER_VERSION}.tgz \
 && mkdir -p /usr/local/bin/ \
 && mv $(find -name 'docker' -type f) /usr/local/bin/ \
 && chmod +x /usr/local/bin/docker \
 && apk del curl \
 && rm -rf /tmp/*
COPY backup-volume.sh /usr/local/bin/backup-volume
COPY restore-volume.sh /usr/local/bin/restore-volume
RUN chmod +x /usr/local/bin/backup-volume; \
    chmod +x /usr/local/bin/restore-volume