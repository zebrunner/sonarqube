FROM sonarqube:7.1

COPY plugins/ /opt/sonarqube/extensions/plugins/
