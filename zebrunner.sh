#!/bin/bash

  start() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    docker network inspect infra >/dev/null 2>&1 || docker network create infra
    docker-compose --env-file .env -f docker-compose.yml up -d
  }

  stop() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    docker-compose --env-file .env -f docker-compose.yml stop
  }

  down() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    docker-compose --env-file .env -f docker-compose.yml down
  }

  shutdown() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    docker-compose --env-file .env -f docker-compose.yml down -v
  }

  backup() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    source .env
    docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/tmp/backup "ubuntu" tar -czvf /tmp/backup/sonarqube.tar.gz /opt/sonarqube
  }

  restore() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    stop
    source .env
    docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/opt/sonarqube/backup "zebrunner/sonarqube:${TAG_SONAR}" bash -c "cd / && tar -xzvf /opt/sonarqube/backup/sonarqube.tar.gz"
    down
  }

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

  status() {
    source .env
    echo "Sonar container status: " `docker ps -af "ancestor=zebrunner/sonarqube:${TAG_SONAR}" --format {{.Status}}`
  }


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${BASEDIR}

case "$1" in
    setup)
        # add rwx permissions for everyone to be able to generate backup file from inside docker container
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
    status)
        status
        ;;
    --help | -h)
        echo_help
        ;;
    *)
        echo "Invalid option detected: $1"
        echo_help
        exit 1
        ;;
esac

