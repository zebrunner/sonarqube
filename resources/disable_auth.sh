#!/bin/bash
wget -q --user=admin --password=admin "http://localhost:9000/api/settings/set?key=sonar.forceAuthentication&value=false"

