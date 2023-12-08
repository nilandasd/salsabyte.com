#!/bin/bash

npm run prod:webpack

aws s3api put-object                      \
  --bucket salsabyte-public-folder-bucket \
  --key main.js                           \
  --body ./public/dist/main.js
