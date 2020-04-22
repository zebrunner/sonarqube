FROM sonarqube:8.2-community

COPY plugins/ /opt/sonarqube/extensions/plugins/
