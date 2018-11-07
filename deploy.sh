#!/bin/bash

echo "Deploying..."

cd builds
cd full && zip -rq ../full.zip . && cd ..
cd bhop && zip -rq ../bhop.zip . && cd ..
cd surf && zip -rq ../surf.zip . && cd ..
cd bhoplite && zip -rq ../bhoplite.zip . && cd ..
tar -cf influx.tar full.zip bhop.zip surf.zip bhoplite.zip

echo "Uploading to site..."

CMD="curl --header \"Content-Type: multipart/form-data\" --request POST --form \"key=$INF_DEPLOY_KEY\" --form \"buildid=$TRAVIS_BUILD_NUMBER\" --form \"commithash=$TRAVIS_COMMIT\" --form \"commitmsg=$TRAVIS_COMMIT_MESSAGE\" --form \"branch=$TRAVIS_BRANCH\" --form \"file=@influx.tar\" \"$INF_DEPLOY_URL\""


echo "Executing: $CMD"

$CMD

echo "Done!"
