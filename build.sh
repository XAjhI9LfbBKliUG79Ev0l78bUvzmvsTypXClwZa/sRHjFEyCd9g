pnpm install
pnpm build

git checkout pages

git rm -rf .
cp -r ../dist/* .
rm -r dist
rm -r node_modules

git add .
git commit -m "Deploy updated dist build to pages branch"

git push origin pages
git checkout main
