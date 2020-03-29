#!/bin/sh

zola build
cd public
rsync -rv * blog@blog.juliobiason.me:
cd ..
