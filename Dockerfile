FROM debian:11

RUN apt update

COPY . /opt

WORKDIR /opt
RUN ./setup.sh

ENTRYPOINT ["./DNS-LDAsPirateur.sh"]