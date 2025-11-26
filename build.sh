#!/usr/bin/env bash
set -euo pipefail
IMAGE_NAME=frontend-build:latest
OUTPUT_DIR="${PWD}/build-output"
mkdir -p "$OUTPUT_DIR"
podman build -t "$IMAGE_NAME" -f Containerfile .
CONTAINER_ID=$(podman create --name temp-build "$IMAGE_NAME")
podman cp "${CONTAINER_ID}:/app/dist/." "$OUTPUT_DIR"
podman rm "$CONTAINER_ID"
echo "Build artifacts copied to: $OUTPUT_DIR"

