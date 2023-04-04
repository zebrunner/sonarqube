FROM sonarqube:9.5.0-community

USER root

COPY resources/healthcheck /usr/local/bin/

RUN mkdir /opt/sonarqube/backup && \
  mkdir -p /opt/sonarqube/data && \
  mkdir -p /opt/sonarqube/logs && \
  mkdir -p /opt/sonarqube/extensions

RUN chown -R sonarqube /opt/sonarqube

USER sonarqube

# download and copy community branch plugin
RUN wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.13.0/sonarqube-community-branch-plugin-1.13.0.jar -P /opt/sonarqube/extensions/plugins/

HEALTHCHECK CMD ["healthcheck"]
