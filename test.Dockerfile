FROM mhart/alpine-node:10.15.1
USER root

WORKDIR /opt/sidecar
# COPY . /opt/sidecar
COPY src /opt/sidecar/src
COPY test /opt/sidecar/test
COPY migrations /opt/sidecar/migrations
COPY config /opt/sidecar/config
COPY package.json server.sh /opt/sidecar/

RUN apk add --no-cache make gcc g++ python && \
    apk add -U iproute2 && ln -s /usr/lib/tc /lib/tc && \
    apk add -U iptables && \
    chmod +x /opt/sidecar/server.sh

RUN npm install -g tape tap-xunit \
    && npm install

EXPOSE 5678

CMD ["/opt/sidecar/server.sh"]
