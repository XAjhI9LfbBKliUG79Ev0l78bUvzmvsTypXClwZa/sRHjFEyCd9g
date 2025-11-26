#!/usr/bin/env bash
set -euo pipefail

BUILD_DIR="${PWD}/dist"
PAGES_BRANCH="pages"
REMOTE="origin"
COMMIT_MSG="Deploy updated dist build to pages branch"
WORKTREE_DIR="$(mktemp -d)"

if [ ! -d "$BUILD_DIR" ] || [ -z "$(ls -A "$BUILD_DIR")" ]; then
  echo "No build found in $BUILD_DIR. Run build.sh first." >&2
  exit 1
fi

git fetch "$REMOTE"

if git ls-remote --exit-code --heads "$REMOTE" "$PAGES_BRANCH" >/dev/null 2>&1; then
  git worktree add --checkout "$WORKTREE_DIR" "$REMOTE/$PAGES_BRANCH"
else
  git worktree add -b "$PAGES_BRANCH" "$WORKTREE_DIR" HEAD
fi

cd "$WORKTREE_DIR"

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

cd - >/dev/null
git worktree remove "$WORKTREE_DIR" --force
rm -rf "$WORKTREE_DIR"

