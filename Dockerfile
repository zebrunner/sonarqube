FROM sonarqube:9.9.0-community

USER root

COPY resources/healthcheck /usr/local/bin/

USER sonarqube

RUN mkdir /opt/sonarqube/backup

COPY plugins/ /opt/sonarqube/extensions/plugins/
COPY plugins/ /opt/sonarqube/lib/common/

HEALTHCHECK CMD ["healthcheck"]
