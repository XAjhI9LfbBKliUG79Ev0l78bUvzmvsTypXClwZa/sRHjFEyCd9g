#!/usr/bin/env bash
set -euo pipefail

ORIG_PWD="$PWD"
BUILD_DIR="${ORIG_PWD}/dist"
PAGES_BRANCH="pages"
REMOTE="origin"
COMMIT_MSG="Deploy updated dist build to pages branch"
WORKTREE_DIR="$(mktemp -d)"

cleanup() {
  cd "$ORIG_PWD" || true 
  if [ -d "$WORKTREE_DIR" ]; then
    git worktree remove "$WORKTREE_DIR" --force 2>/dev/null || true
    rm -rf "$WORKTREE_DIR"
  fi
}
trap cleanup EXIT

if [ ! -d "$BUILD_DIR" ] || [ -z "$(ls -A "$BUILD_DIR")" ]; then
  echo "No build found in $BUILD_DIR. Run build.sh first." >&2
  exit 2
fi

git fetch "$REMOTE"

if git ls-remote --exit-code --heads "$REMOTE" "$PAGES_BRANCH" >/dev/null 2>&1; then
  git worktree add --checkout "$WORKTREE_DIR" "$REMOTE/$PAGES_BRANCH"
else
  git worktree add --detach "$WORKTREE_DIR"
  cd "$WORKTREE_DIR"
  git switch --orphan "$PAGES_BRANCH"
  cd "$ORIG_PWD"
fi

cd "$WORKTREE_DIR"

git rm -rf . || true
cp -a "${BUILD_DIR}/." .
rm -rf dist node_modules || true

git add --all
if git diff --cached --quiet; then
  echo "No changes to deploy."
else
  git commit -m "$COMMIT_MSG"
  git push "$REMOTE" "HEAD:refs/heads/$PAGES_BRANCH"
fi
