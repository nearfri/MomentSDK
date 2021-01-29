#!/bin/bash

set -e

cd $(dirname "$BASH_SOURCE")/../Projects/Carthage-XcodeGen
mint run xcodegen
