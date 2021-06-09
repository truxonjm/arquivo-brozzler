FROM python:3.6-alpine

RUN export LC_ALL=C.UTF-8 && \
    apk add --update build-base libffi libffi-dev openssl openssl-dev git curl bash && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y && \
    source $HOME/.cargo/env && \
    pip install warcprox===2.4.17 && \
    apk del build-base libffi-dev openssl-dev bash

ARG RETHINKDB_SERVER="localhost"
ARG RETHINKDB_SERVER_PORT="28015"
ARG WARCPROXY_PORT="9000"
ARG DATA_FOLDER="/data"

ENV RETHINKDB_SERVER=${RETHINKDB_SERVER}
ENV RETHINKDB_SERVER_PORT=${RETHINKDB_SERVER_PORT}
ENV WARCPROXY_PORT=${WARCPROXY_PORT}
ENV DATA_FOLDER=${DATA_FOLDER}

EXPOSE ${WARCPROXY_PORT}

CMD warcprox --method-filter=GET --method-filter=POST --rethinkdb-services-url rethinkdb://${RETHINKDB_SERVER}:${RETHINKDB_SERVER_PORT}/brozzler/services --rethinkdb-big-table-url rethinkdb://${RETHINKDB_SERVER}:${RETHINKDB_SERVER_PORT}/brozzler/captures --rethinkdb-stats-url rethinkdb://${RETHINKDB_SERVER}:${RETHINKDB_SERVER_PORT}/brozzler/stats -s 104857600 -b 0.0.0.0 --rollover-idle-time 3600 -p ${WARCPROXY_PORT} --base32 -z -d ${DATA_FOLDER}/warcs --crawl-log-dir ${DATA_FOLDER}/logs --blackout-period 10