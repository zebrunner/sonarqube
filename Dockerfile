FROM sonarqube:7.9.3-community

USER root

RUN apt-get update -y
RUN apt-get install wget -y
COPY docker-healthcheck /usr/local/bin/

USER sonarqube

RUN mkdir /opt/sonarqube/backup

COPY plugins/ /opt/sonarqube/extensions/plugins/
COPY plugins/ /opt/sonarqube/lib/common/

HEALTHCHECK CMD ["docker-healthcheck"]
