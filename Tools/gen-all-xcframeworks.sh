#!/bin/bash

set -e

cd $(dirname "$BASH_SOURCE")

./gen-xcframework.sh MomentCommon
./gen-xcframework.sh MomentEditor
./gen-xcframework.sh MomentPlayer
