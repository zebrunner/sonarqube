FROM sonarqube:9.5.0-community

USER root

COPY resources/healthcheck /usr/local/bin/

RUN mkdir /opt/sonarqube/backup && \
  mkdir -p /opt/sonarqube/data && \
  mkdir -p /opt/sonarqube/logs && \
  mkdir -p /opt/sonarqube/extensions

RUN chown -R sonarqube /opt/sonarqube

USER sonarqube

COPY plugins/ /opt/sonarqube/extensions/plugins/
#COPY plugins/ /opt/sonarqube/lib/common/

HEALTHCHECK CMD ["healthcheck"]
