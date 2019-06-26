#/bin/sh

set -eu

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
  docker stop "$container_name" && echo "Stopped"
fi

cd /source &&

for volume_name do
  echo "Restoring volume '$volume_name'..."
  tar xfz "/target/$volume_name.tar.gz" "$volume_name" && echo "Done"
done

if [ ! -z $container_name ]
then
  echo "Starting container '$container_name'..."
  docker start "$container_name" && echo "Started"
fi
