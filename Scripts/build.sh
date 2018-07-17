#!/bin/bash

if [ "$1" == "travis" ]; then
  : ${GIT_CRYPT?"GIT_CRYPT key not set"}
  git-crypt unlock <(echo "$GIT_CRYPT" | base64 -D)
fi

function pretty() {
	bundle exec xcpretty -f $(bundle exec xcpretty-travis-formatter) && exit ${PIPESTATUS[0]}
}

for CONFIG in "Debug" "Release"; do
  xcodebuild \
    -workspace "CointrackingBar.xcworkspace" \
    -scheme "CointrackingBar" \
    -configuration "$CONFIG" \
    clean build | pretty
done
