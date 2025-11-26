#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${PWD}/dist"
PAGES_BRANCH="pages"
REMOTE="origin"
COMMIT_MSG="Deploy updated dist build to pages branch"

if [ ! -d "$BUILD_DIR" ] || [ -z "$(ls -A "$BUILD_DIR")" ]; then
  echo "No build found in $BUILD_DIR. Run build.sh first." >&2
  exit 1
fi

git fetch "$REMOTE"
git worktree add /tmp/pages "$REMOTE/$PAGES_BRANCH" 2>/dev/null || true
pushd /tmp/pages >/dev/null

git rm -rf . || true
cp -r "${BUILD_DIR}/." .
rm -rf dist node_modules || true

git add --all
if git diff --cached --quiet; then
  echo "No changes to deploy."
else
  git commit -m "$COMMIT_MSG"
  git push "$REMOTE" "HEAD:refs/heads/$PAGES_BRANCH"
fi

popd >/dev/null
git worktree remove /tmp/pages --force >/dev/null || true

