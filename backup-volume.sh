#!/bin/bash

set -eu

readonly INVALID_ARGS=1
readonly STOP_FAILED=2
readonly CREATE_FAILED=3
readonly START_FAILED=4

function usage {
  cat <<EOM
usage: $(basename "$0") [--container=<container_name>] <image_name>*
  --container   specify container to stop during backup
EOM
  exit $INVALID_ARGS
}

[ $# -eq 0 ] && { usage; }

container_name=

for arg do
  shift
  value="${arg#--container=}"
  if [ "$value" != "$arg" ]
  then
    container_name="$value"
    continue
  fi
  set -- "$@" "$arg"
done

if [ ! -z "$container_name" ]
then
  echo "Stopping container '$container_name'..."
  docker stop "$container_name" \
    && echo "Stopped" \
    || { >&2 echo "Failed"; exit $STOP_FAILED; }
else
  echo "No container will be stopped/started"
fi

for volume_name do
  echo "Backing up volume '$volume_name'..."
  tar -czp -f "/target/$volume_name.tar.gz" -C "/source/$volume_name" . \
    && echo "Done" \
    || { >&2 echo "Failed"; exit $CREATE_FAILED; }
done

if [ ! -z "$container_name" ]
then
  echo "Starting container '$container_name'..."
  docker start "$container_name" \
    && echo "Started" \
    || { >&2 echo "Failed"; exit $START_FAILED; }
fi
