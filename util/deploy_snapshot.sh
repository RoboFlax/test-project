#!/bin/bash

# see https://coderwall.com/p/9b_lfq

set -e -u

function mvn_deploy() {
  mvn clean source:jar javadoc:jar deploy \
    --settings="$(dirname $0)/settings.xml" -DskipTests=true "$@"
}

if [ "$TRAVIS_REPO_SLUG" == "RoboFlax/test-repo" ] && \
   [ "$TRAVIS_JDK_VERSION" == "oraclejdk8" ] && \
   [ "$TRAVIS_PULL_REQUEST" == "false" ] && \
   [ "$TRAVIS_BRANCH" == "master" ]; then
  echo "Publishing Maven snapshot..."

  mvn_deploy

  echo "Maven snapshot published."
fi