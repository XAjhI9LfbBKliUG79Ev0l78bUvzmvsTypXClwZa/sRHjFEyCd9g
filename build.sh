#!/usr/bin/env bash
set -euo pipefail
IMAGE_NAME=frontend-build:latest

mkdir -p "$OUTPUT_DIR"

podman build -t "$IMAGE_NAME" -f Containerfile .

CONTAINER_ID=$(podman create --name temp-build "$IMAGE_NAME")

podman cp "${CONTAINER_ID}:/app/dist/" .
podman rm "$CONTAINER_ID"

echo "Build artifacts copied to: $OUTPUT_DIR"

