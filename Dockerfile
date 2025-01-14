FROM centos:7

LABEL org.opencontainers.image.authors="Babak@Babak.pw"



RUN \
  yum update -y && \
  yum install -y epel-release  java-1.8.0-openjdk wget && \
  yum install -y net-tools hostname inotify-tools yum-utils  python3 && \
  yum clean all 

RUN \
    pip3 install supervisor 

ENV FILE https://downloads-guests.open.collab.net/files/documents/61/17071/CollabNetSubversionEdge-5.2.0_linux-x86_64.tar.gz

RUN wget --no-check-certificate -q ${FILE} -O /tmp/csvn.tgz && \
    mkdir -p /opt/csvn && \
    tar -xzf /tmp/csvn.tgz -C /opt/csvn --strip=1 && \
    rm -rf /tmp/csvn.tgz

ENV RUN_AS_USER collabnet


RUN useradd collabnet && \
    chown -R collabnet.collabnet /opt/csvn && \
    cd /opt/csvn && \
    ./bin/csvn install && \
    mkdir -p ./data-initial && \
    cp -r ./data/* ./data-initial

EXPOSE 3343 4434 18080

ADD files /

VOLUME /opt/csvn/data

WORKDIR /opt/csvn

ENTRYPOINT ["/config/bootstrap.sh"]