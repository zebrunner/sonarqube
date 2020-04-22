FROM sonarqube:8.2-community

COPY plugins/ /opt/sonarqube/extensions/plugins/
RUN ls /opt/sonarqube/extensions/plugins/

# remove previous plugin versions to fix failure(s) on startup:
# 2020.04.22 10:08:54 ERROR web[][o.s.s.p.PlatformImpl] Web server startup failed: Found two versions of the plugin SonarJava [java] in the directory extensions/plugins. 
# Please remove one of sonar-java-plugin-6.1.0.20866.jar or sonar-java-plugin-6.3.0.21585.jar.

RUN cd /opt/sonarqube/extensions/plugins && \
	rm sonar-csharp-plugin-8.4.0.15306.jar sonar-java-plugin-6.1.0.20866.jar sonar-python-plugin-2.5.0.5733.jar sonar-scm-git-plugin-1.9.1.1834.jar

RUN ls /opt/sonarqube/extensions/plugins/
