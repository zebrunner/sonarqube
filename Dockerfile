FROM sonarqube:7.9.3-community

RUN mkdir /opt/sonarqube/backup

COPY plugins/ /opt/sonarqube/extensions/plugins/
COPY plugins/ /opt/sonarqube/lib/common/

HEALTHCHECK CMD ["docker-healthcheck"]
