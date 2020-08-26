#!/bin/bash

  echo_warning() {
    echo "
      WARNING! $1"
  }

  echo_telegram() {
    echo "
      For more help join telegram channel: https://t.me/zebrunner
      "
  }

  status() {
    source .env
    local container_name="sonarqube"
    local container_status=`docker inspect $container_name -f {{.State.Health.Status}} > /dev/null 2>&1`
    if [[ -z $container_status ]]; then
       echo_warning "There's no container $container_name"
       exit 1
    fi

    echo "$container_name is $container_status"

    case "$container_status" in
        "healthy")
            return 0
            ;;
        "unhealthy")
            return 1 
            ;;
        "starting")
            return 2
            ;;
    esac
  }

  setup() {
    # PREREQUISITES: valid values inside ZBR_PROTOCOL, ZBR_HOSTNAME and ZBR_PORT env vars!
    echo "sonarqube: no setup steps required."
  }

  shutdown() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    docker-compose --env-file .env -f docker-compose.yml down -v
  }

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

  backup() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    status
    if [[ $? == 0 ]]; then
      echo "Backuping container..."
      docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/var/backup "ubuntu" tar -czvf /var/backup/sonarqube.tar.gz /opt/sonarqube
    else
      echo_warning "There's no running Sonarqube container"
      echo_telegram
    fi
  }

  restore() {
    if [[ -f .disabled ]]; then
      exit 0
    fi

    status
    if [[ $? == 0 ]]; then
      echo "Restoring container..."
      stop
      docker run --rm --volumes-from sonarqube -v $(pwd)/backup:/var/backup "ubuntu" bash -c "cd / && tar -xzvf /var/backup/sonarqube.tar.gz"
      down
    else
      echo_warning "There's no running Sonarqube container"
      echo_telegram
    fi
  }

  echo_help() {
    echo "
      Usage: ./zebrunner.sh [option]
      Flags:
          --help | -h    Print help
      Arguments:
      	  start          Start container
      	  stop           Stop and keep container
          status         Show sonarqube container status
      	  restart        Restart container
      	  down           Stop and remove container
      	  shutdown       Stop and remove container, clear volumes
      	  backup         Backup container
      	  restore        Restore container"
      echo_telegram
      exit 0
  }

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd ${BASEDIR}

case "$1" in
    setup)
        setup
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

