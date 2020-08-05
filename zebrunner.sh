#!/bin/bash

  print_banner() {
    echo "Welcome to Zebrunner Sonarqube (Community Edition)"
  }

  start() {
    docker network inspect infra >/dev/null 2>&1 || docker network create infra
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      docker-compose --env-file ${BASEDIR}/.env -f ${BASEDIR}/docker-compose.yml up -d
    fi
  }

  stop() {
    # stop and keep container
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      docker-compose --env-file ${BASEDIR}/.env -f ${BASEDIR}/docker-compose.yml stop
    fi
  }

  down() {
    # stop and remove container
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      docker-compose --env-file ${BASEDIR}/.env -f ${BASEDIR}/docker-compose.yml down
    fi
  }

  shutdown() {
    # stop and remove container, clear volumes
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      docker-compose --env-file ${BASEDIR}/.env -f ${BASEDIR}/docker-compose.yml down -v
    fi
  }

  backup() {
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      source ${BASEDIR}/.env
      docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/opt/sonarqube/backup "qaprosoft/sonarqube:${TAG_SONAR}" tar -czvf /opt/sonarqube/backup/sonarqube.tar.gz /opt/sonarqube/data /opt/sonarqube/extensions
    fi
  }

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${BASEDIR}

print_banner

case "$1" in
    start)
	start 
        ;;
    stop)
        stop
        ;;
    down)
        down
        ;;
    shutdown)
        shutdown
        ;;
    backup)
        backup
	;;
    *)
        echo "Usage: ./zebrunner.sh start|stop|down|shutdown|backup|restore"
        exit 1
        ;;
esac
