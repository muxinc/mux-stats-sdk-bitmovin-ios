#!/bin/bash
set -euo pipefail

cd MUXSDKBitmovin
pod repo update
pod deintegrate && pod install
cd ..
./update-release-xcframeworks.sh
zip -ry MUXSDKBitmovin.xcframework.zip XCFramework
