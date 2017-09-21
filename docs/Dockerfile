FROM gliderlabs/alpine:latest

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apk-install python3 vim bash curl git libstdc++ openssh-client            \
        build-base libffi-dev openssl-dev libxml2-dev libxslt-dev python3-dev \
        jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev        \
    && curl "https://bootstrap.pypa.io/get-pip.py" | python3                  \
    && pip3 install --upgrade pip setuptools                                  \
    && apk del build-base                                                     \
    && mkdir -p /opt /app

# prepare our container for mkdocs
WORKDIR /app

# setup entrypoint
COPY entrypoint.sh /
RUN  chmod +x /entrypoint.sh

# install mkdocs
RUN pip3 install mkdocs mkdocs-material

# allow for serving the site for local testing
EXPOSE 8000

# needful metadata
VOLUME ["/app"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]