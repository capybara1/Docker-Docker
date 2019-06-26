#/bin/sh

set -eu

function usage {
  cat <<EOM
usage: $(basename $0) [--container=<container_name>] <image_name>*
  --container   specify container to stop during restore
EOM
  exit 1
}

[ -z $1 ] && { usage; }

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
  docker stop "$container_name" && echo "Stopped" || >&2 echo "Failed"
fi

cd /target

for volume_name do
  echo "Clearing volume '$volume_name'..."
  rm -rf "$volume_name/*" "$volume_name/..?*" "$volume_name/.[!.]*" && echo "Done" || >&2 echo "Failed" 
  echo "Restoring volume '$volume_name'..."
  tar xfz "/source/$volume_name.tar.gz" "$volume_name" && echo "Done" || >&2 echo "Failed"
done

if [ ! -z $container_name ]
then
  echo "Starting container '$container_name'..."
  docker start "$container_name" && echo "Started" || >&2 echo "Failed"
fi
