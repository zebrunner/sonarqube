FROM sonarqube:5.6.7-alpine

COPY plugins/ /opt/sonarqube/extensions/plugins/
