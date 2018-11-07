#!/bin/bash

echo "Deploying..."

# Zip em and roll em into a tar ball
cd builds
cd full && zip -rq9 ../full.zip . && cd ..
cd bhop && zip -rq9 ../bhop.zip . && cd ..
cd surf && zip -rq9 ../surf.zip . && cd ..
cd bhoplite && zip -rq9 ../bhoplite.zip . && cd ..
tar -cf influx.tar full.zip bhop.zip surf.zip bhoplite.zip

echo "Uploading to site..."

curl -H "Content-Type: multipart/form-data" -X POST \
-F "key=$INF_DEPLOY_KEY" \
-F "buildnum=$TRAVIS_BUILD_NUMBER" \
-F "commithash=$TRAVIS_COMMIT" \
-F "commitmsg=$TRAVIS_COMMIT_MESSAGE" \
-F "branch=$TRAVIS_BRANCH" \
-F "file=@influx.tar" \
"$INF_DEPLOY_URL"

echo "Done!"
