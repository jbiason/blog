#!/bin/sh

git tag -f `date +'%Y%m%d'`

zola build
cd public
rsync -rv * blog@blog.juliobiason.me: --delete
cd ..
