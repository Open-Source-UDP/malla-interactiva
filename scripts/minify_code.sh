#!/bin/bash

# based on:
# https://unix.stackexchange.com/questions/249701/how-to-minify-javascript-and-css-with-command-line-using-minify-tool
# minification of js files

./scripts/minify_dev.sh
npx terser js/init.js -c -m -o js/init.js
find js/ -regex '.*[^(?:min[0-9+)|(init)]\.js' \
  -delete

# minification of css files
find css/ -type f \
    -name "*.css" ! -name "*.min.*" \
    -exec echo {} \; \
    -exec npx csso --input {} --output {}.min \; \
    -exec rm {} \; \
    -exec mv -f {}.min {} \;

# compress js files even more with gzip
# gzip js/*

# Create file representing last update date
date +"%s000" | tee date.txt

# moves assets to root
cp ./assets/* ./
