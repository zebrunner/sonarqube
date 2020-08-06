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
      docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/opt/sonarqube/backup "zebrunner/sonarqube:${TAG_SONAR}" tar -czvf /opt/sonarqube/backup/sonarqube.tar.gz /opt/sonarqube/data /opt/sonarqube/extensions
    fi
  }

  restore() {
    if [[ ! -f ${BASEDIR}/.disabled ]]; then
      source ${BASEDIR}/.env
      docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/opt/sonarqube/backup "zebrunner/sonarqube:${TAG_SONAR}" bash -c "cd / && tar -xzvf /opt/sonarqube/backup/sonarqube.tar.gz"
    fi
  }


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${BASEDIR}

print_banner

echo_help() {
  echo "
      Usage: ./zebrunner.sh [option]

      Flags:
          --help | -h    Print help
      Arguments:
      	  start          Start container
      	  stop           Stop and keep container
      	  restart        Restart container
      	  down           Stop and remove container
      	  shutdown       Stop and remove container, clear volumes
      	  backup         Backup container
      	  restore        Restore container

      For more help join telegram channel https://t.me/qps_infra"
      exit 0
  }

case "$1" in
    setup)
        # add rwx permissions for everyone to be able to generate backup file from inside docker container
        chmod a+rwx ./backup
        ;;
    start)
	start 
        ;;
    stop)
        stop
        ;;
    restart)
        down
        start
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
    restore)
        restore
        ;;
    --help | -h)
        echo_help
        ;;
    *)
        echo "Invalin option was find!"
        echo_help
        exit 1
        ;;
esac

