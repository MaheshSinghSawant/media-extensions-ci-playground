#!/bin/bash
source $(dirname $0)/shared.sh

EXTENSION=$1
set_tag_version $EXTENSION

# Validate the version matches in the project matches the version created by a user
VERSION=$(node -pe "require('$EXTENSION/package.json').version")
if [ "$TAG_VERSION" == "$VERSION" ]; then
  echo "Release tag matches current version"

  # Add the version to the extension's public directory
  echo $VERSION > $EXTENSION/public/version.txt
else
  echo "Release tag does not match current version. TAG_VERSION=$TAG_VERSION VERSION=$VERSION"
  exit 1
fi