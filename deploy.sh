#!/bin/bash

echo "Deploying..."

cd builds
cd full && zip -rq ../full.zip . && cd ..
cd bhop && zip -rq ../bhop.zip . && cd ..
cd surf && zip -rq ../surf.zip . && cd ..
cd bhoplite && zip -rq ../bhoplite.zip . && cd ..
tar -cf influx.tar full.zip bhop.zip surf.zip bhoplite.zip

echo "Uploading to site..."

curl -H "Content-Type: multipart/form-data" -X POST \
-F "key=$INF_DEPLOY_KEY" \
-F "buildid=$TRAVIS_BUILD_NUMBER" \
-F "commithash=$TRAVIS_COMMIT" \
-F "commitmsg=$TRAVIS_COMMIT_MESSAGE" \
-F "branch=$TRAVIS_BRANCH" \
-F "file=@influx.tar" \
"$INF_DEPLOY_URL"

echo "Done!"
