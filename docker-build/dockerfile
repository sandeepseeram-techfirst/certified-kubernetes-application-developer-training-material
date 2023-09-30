FROM ubuntu:impish

COPY ./code /opt/gowebapp
COPY ./config /opt/gowebapp/config

EXPOSE 8080
USER 1000

WORKDIR /opt/gowebapp/
ENTRYPOINT ["/opt/gowebapp/gowebapp"]