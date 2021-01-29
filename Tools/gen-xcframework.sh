#!/bin/bash

set -e

cd $(dirname "$BASH_SOURCE")/..

# XCFramework path
FRAMEWORK_NAME=$1
FRAMEWORK_DIR="MomentSDK_XCFramework/${FRAMEWORK_NAME}"
XCFRAMEWORK_NAME="${FRAMEWORK_NAME}.xcframework"
XCFRAMEWORK_PATH="${FRAMEWORK_DIR}/${XCFRAMEWORK_NAME}"
DERIVED_DATA_DIR="${FRAMEWORK_DIR}/DerivedData"
SUBMODULES_DIR="${FRAMEWORK_DIR}/Submodules"
IOS_DEVICE_SUBMODULES_DIR="${SUBMODULES_DIR}/ios-arm64"
IOS_SIMULATOR_SUBMODULES_DIR="${SUBMODULES_DIR}/ios-arm64 x86_64-simulator"
BUILD_PRODUCTS_PATH="${DERIVED_DATA_DIR}/Build/Intermediates.noindex/ArchiveIntermediates/${FRAMEWORK_NAME}/BuildProductsPath"

IOS_DEVICE_ARCHIVE_PATH="${FRAMEWORK_DIR}/ios.xcarchive"
IOS_SIMULATOR_ARCHIVE_PATH="${FRAMEWORK_DIR}/ios-sim.xcarchive"
#MACOS_ARCHIVE_PATH="${FRAMEWORK_DIR}/macos.xcarchive"

if [ -z "${FRAMEWORK_NAME}" ]; then
    echo "usage: $(basename $BASH_SOURCE) <framework_name>"
    exit 1
fi

rm -rf "${FRAMEWORK_DIR}"

mkdir -p "${FRAMEWORK_DIR}"
mkdir "${DERIVED_DATA_DIR}"
mkdir -p "${IOS_DEVICE_SUBMODULES_DIR}"
mkdir -p "${IOS_SIMULATOR_SUBMODULES_DIR}"

echo "Archiving ${FRAMEWORK_NAME}"
xcodebuild archive -scheme ${FRAMEWORK_NAME} -derivedDataPath ${DERIVED_DATA_DIR} -destination "generic/platform=iOS" \
    -archivePath "${IOS_DEVICE_ARCHIVE_PATH}" -sdk iphoneos SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
find "${BUILD_PRODUCTS_PATH}/Release-iphoneos" -name "${FRAMEWORK_NAME}*.swiftmodule" -maxdepth 1 -type d | xargs -JFILE cp -r FILE "${IOS_DEVICE_SUBMODULES_DIR}"

xcodebuild archive -scheme ${FRAMEWORK_NAME} -derivedDataPath ${DERIVED_DATA_DIR} -destination="generic/platform=iOS Simulator" \
    -archivePath "${IOS_SIMULATOR_ARCHIVE_PATH}" -sdk iphonesimulator SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
find "${BUILD_PRODUCTS_PATH}/Release-iphonesimulator" -name "${FRAMEWORK_NAME}*.swiftmodule" -maxdepth 1 -type d | xargs -JFILE cp -r FILE "${IOS_SIMULATOR_SUBMODULES_DIR}"

#xcodebuild archive -scheme ${FRAMEWORK_NAME} -destination="generic/platform=macOS" -archivePath "${MACOS_ARCHIVE_PATH}" -sdk macosx SKIP_INSTALL=NO #BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# .swiftinterface 파일이 있다면 .swiftmodule 파일은 필요없다.
find "${SUBMODULES_DIR}" -name "*.swiftmodule" -maxdepth 3 -type f -exec rm {} \;

# Creating XCFramework
xcodebuild -create-xcframework \
-framework "${IOS_DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-debug-symbols "$(pwd)/${IOS_DEVICE_ARCHIVE_PATH}/dSYMs/${FRAMEWORK_NAME}.framework.dSYM" \
-debug-symbols "$(pwd)/$(find "${IOS_DEVICE_ARCHIVE_PATH}/BCSymbolMaps" -name "*.bcsymbolmap")" \
-framework "${IOS_SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework" \
-debug-symbols "$(pwd)/${IOS_SIMULATOR_ARCHIVE_PATH}/dSYMs/${FRAMEWORK_NAME}.framework.dSYM" \
-output "${XCFRAMEWORK_PATH}"

#-framework ${MACOS_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
#-debug-symbols ${MACOS_ARCHIVE_PATH}/dSYMs/${FRAMEWORK_NAME}.framework.dSYM \

mv "${SUBMODULES_DIR}" "${XCFRAMEWORK_PATH}"

# Zip XCFramework
pushd "${FRAMEWORK_DIR}"
zip -r -X "${XCFRAMEWORK_NAME}.zip" "${XCFRAMEWORK_NAME}"
popd

mv "${FRAMEWORK_DIR}/${XCFRAMEWORK_NAME}.zip" "${FRAMEWORK_DIR}/.."

# rm -rf "${IOS_SIMULATOR_ARCHIVE_PATH}"
# rm -rf "${IOS_DEVICE_ARCHIVE_PATH}"
rm -rf "${FRAMEWORK_DIR}"

# open "${FRAMEWORK_DIR}"
