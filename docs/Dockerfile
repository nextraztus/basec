FROM python:3.6-slim-buster

# prepare our container for mkdocs
WORKDIR /app

# install mkdocs
RUN pip3 install mkdocs mkdocs-material

# setup entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# allow for serving the site for local testing
EXPOSE 8000

# needful metadata
VOLUME ["/app"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh"]
