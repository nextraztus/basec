FROM ubuntu:20.04

# necessary tools for compiling things; we purposely leave the apt cache available
# for any additional packages that need to be built into this container
RUN apt-get update \
 && apt-get install -y locales \
    build-essential \
    clang-12 \
    clang-tools-12 \
    clang-format-12 \
    sudo \
    nasm \
    vim \
    dc \
 && mkdir /compile \
 && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

WORKDIR /compile

# setup entrypoint
COPY docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh

# install any c libraries we need
RUN apt-get install -y \
    libsqlite3-dev

VOLUME ["/compile"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]
