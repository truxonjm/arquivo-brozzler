# based on https://github.com/ukwa/docker-brozzler
# FROM ubuntu:20.04
FROM debian:latest 

ENV DEBIAN_FRONTEND=noninteractive

# Install suitable version of Python:
RUN apt-get update
RUN apt-get install -y python3-dev python3-gdbm curl git libffi-dev libssl-dev
RUN curl "https://bootstrap.pypa.io/get-pip.py" | python3

RUN apt-get -y install gcc

# Accept EULA for MS fonts
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections # Accept EULA for MS fonts

# Install browser and fonts
RUN apt-get install -y software-properties-common x11vnc xvfb && \
    apt-add-repository contrib && \
    apt-get update && \
    apt-get install -y chromium xfonts-base fonts-arphic-bkai00mp \
      fonts-arphic-bsmi00lp fonts-arphic-gbsn00lp fonts-arphic-gkai00mp fonts-arphic-ukai \
      fonts-farsiweb fonts-nafees fonts-sil-abyssinica fonts-sil-ezra fonts-sil-padauk \
      fonts-unfonts-extra fonts-unfonts-core fonts-indic fonts-thai-tlwg fonts-lklug-sinhala ttf-mscorefonts-installer

# Install brozzler itself:
RUN export LC_ALL=C.UTF-8 && \
    # pip3 install 'git+https://github.com/internetarchive/brozzler.git@4df280a9b619c6a5b88c84dbe670602721c025ea'
    pip3 install brozzler==1.5.18

RUN apt-get install -y dbus

RUN useradd -ms /bin/bash brozzler

ADD xvfb-run-chromium-browser.sh /usr/bin

USER brozzler
WORKDIR /home/brozzler

# example --trace
ARG EXTRA_ARGS

CMD brozzler-worker -n 1 --warcprox-auto --rethinkdb-db brozzler --rethinkdb-server ${BROZZLER_RETHINKDB_SERVERS} -e /usr/bin/xvfb-run-chromium-browser.sh ${EXTRA_ARGS}