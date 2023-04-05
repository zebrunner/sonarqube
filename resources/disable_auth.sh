#!/bin/bash
wget -q --post-data '' "http://admin:admin@localhost:9000/sonarqube/api/settings/set?key=sonar.forceAuthentication&value=false"

