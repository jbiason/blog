#!/bin/sh

git tag `date +'%Y%m%d'`

zola build
cd public
rsync -rv * blog@blog.juliobiason.me:
cd ..
