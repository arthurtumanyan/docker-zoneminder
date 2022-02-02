FROM debian:bullseye
LABEL maintainer="Arthur Tumanyan <arthurtumanyan@gmail.com>"
ENV DEBIAN_FRONTEND=noninteractive
ENV EDITOR=/usr/bin/vim


RUN apt-get -qy update && apt-get -qy full-upgrade && \
    apt-get -qy install apache2 mariadb-server php libapache2-mod-php php-mysql lsb-release gnupg2 dos2unix dnsutils \
    curl wget software-properties-common apt-transport-https git net-tools tzdata inetutils-ping vim bc sudo

RUN [ -f /etc/localtime ] && unlink /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Yerevan /etc/localtime
RUN echo "deb https://zmrepo.zoneminder.com/debian/release-1.36 "`lsb_release -c -s`"/" >> /etc/apt/sources.list.d/zoneminder.list
RUN wget -O - https://zmrepo.zoneminder.com/debian/archive-keyring.gpg | sudo apt-key add -
RUN sudo apt-get -qy update && apt-get -qy install zoneminder=1.36.11-bullseye1

COPY runit.sh /
RUN dos2unix /runit.sh
ENTRYPOINT [ "/bin/bash", "/runit.sh" ]