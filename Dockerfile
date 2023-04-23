FROM sonarqube:9.8.0-community

ARG BRANCH_PLUGIN_VERSION=1.14.0

USER root

COPY resources/healthcheck /usr/local/bin/

RUN mkdir /opt/sonarqube/backup && \
  mkdir -p /opt/sonarqube/data && \
  mkdir -p /opt/sonarqube/logs && \
  mkdir -p /opt/sonarqube/extensions/plugins && \
  mkdir -p /opt/sonarqube/lib/common

RUN chown -R sonarqube /opt/sonarqube

USER sonarqube

# download and register community branch plugin based on instructions: https://github.com/mc1arke/sonarqube-community-branch-plugin#manual-install
#
#  Copy the plugin JAR file to the extensions/plugins/ directory of your SonarQube instance
#  Add -javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${version}.jar=web to the sonar.web.javaAdditionalOpts property in your Sonarqube installation's conf/sonar.properties file, e.g. sonar.web.javaAdditionalOpts=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${version}.jar=web where ${version} is the version of the plugin being worked with. e.g 1.8.0
#  Add -javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${version}.jar=ce to the sonar.ce.javaAdditionalOpts property in your Sonarqube installation's conf/sonar.properties file, e.g. sonar.ce.javaAdditionalOpts=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${version}.jar=ce
#  Start Sonarqube, and accept the warning about using third-party plugins

RUN wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/${BRANCH_PLUGIN_VERSION}/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar -P /opt/sonarqube/extensions/plugins/ && \
  chmod 744 /opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar

RUN wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/${BRANCH_PLUGIN_VERSION}/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar -P /opt/sonarqube/lib/common/ && \
  chmod 744 /opt/sonarqube/lib/common/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar

RUN chmod +w /opt/sonarqube/conf/sonar.properties && \
  echo >> /opt/sonarqube/conf/sonar.properties && \
  echo "sonar.web.javaAdditionalOpts=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar=web" >> /opt/sonarqube/conf/sonar.properties && \
  echo "sonar.ce.javaAdditionalOpts=-javaagent:./extensions/plugins/sonarqube-community-branch-plugin-${BRANCH_PLUGIN_VERSION}.jar=ce" >> /opt/sonarqube/conf/sonar.properties && \
  chmod -w /opt/sonarqube/conf/sonar.properties


HEALTHCHECK CMD ["healthcheck"]
