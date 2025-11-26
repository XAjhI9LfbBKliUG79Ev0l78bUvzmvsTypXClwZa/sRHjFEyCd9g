#!/usr/bin/env bash
set -euo pipefail
HOST_DIR="${PWD}/build-output"
if [ ! -d "$HOST_DIR" ] || [ -z "$(ls -A "$HOST_DIR")" ]; then
  echo "No build in $HOST_DIR. Run ./build.sh first." >&2
  exit 1
fi
podman run --rm -p 8080:80 -v "${HOST_DIR}":/usr/share/nginx/html:Z docker.io/library/nginx:alpine

