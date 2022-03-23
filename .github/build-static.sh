#!/bin/bash
set -euo pipefail

cd MUXSDKBitmovin
pod repo update
pod deintegrate && pod install
cd ..
./update-release-xcframeworks-static.sh
zip -ry MUXSDKBitmovin-static.xcframework.zip XCFramework
