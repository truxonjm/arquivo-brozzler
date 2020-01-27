FROM ubuntu:16.04

# Install suitable version of Python:
RUN apt-get update
RUN apt-get install -y python3-dev python3-gdbm curl git libffi-dev libssl-dev
RUN curl "https://bootstrap.pypa.io/get-pip.py" | python3.5

RUN apt-get -y install gcc

# Install brozzler itself:
RUN export LC_ALL=C.UTF-8 && \
    pip3.5 install 'git+https://github.com/internetarchive/brozzler.git@8beb96817ef96cefc1add4815ece3935b49595ce#egg=brozzler[easy]' 

RUN pip3.5 install 'git+https://github.com/arquivo/brozzleradmin.git@v0.3.4'

RUN apt-get install -y dbus

RUN useradd -ms /bin/bash brozzler

EXPOSE 8000
EXPOSE 5001
EXPOSE 8880

USER brozzler
WORKDIR /home/brozzler

COPY . .

ARG RETHINKDB_SERVER="localhost"
ARG RETHINKDB_SERVER_PORT="28015"
ARG DASHBOARD_PORT="8000"
ARG DASHBOARD_INTERFACE="0.0.0.0"
ARG WAYBACK_BASEURL="http://localhost:8880/brozzler"
ARG BROZZLER_RETHINKDB_SERVERS="localhost"
ARG BROZZLER_RETHINKDB_DB="localhost"
ARG BROZZLER_ADMIN_CONFIGURATION="./config.py"

ENV BROZZLER_ADMIN_CONFIGURATION = ${BROZZLER_ADMIN_CONFIGURATION}

ENV RETHINKDB_SERVER=${RETHINKDB_SERVER}
ENV RETHINKDB_SERVER_PORT=${RETHINKDB_SERVER_PORT}

ENV BROZZLER_RETHINKDB_SERVERS=${RETHINKDB_SERVER}
ENV BROZZLER_RETHINKDB_DB=${BROZZLER_RETHINKDB_DB}

ENV PYWB_CONFIG_FILE=/home/brozzler/pywb.yml

ENV BROZZLER_ADMIN_CONFIGURATION=/home/brozzler/config.py
ENV DASHBOARD_PORT=${DASHBOARD_PORT}
ENV DASHBOARD_INTERFACE=${DASHBOARD_INTERFACE}
ENV WAYBACK_BASEURL=${WAYBACK_BASEURL}


# default app is dashboard
CMD brozzler-dashboard