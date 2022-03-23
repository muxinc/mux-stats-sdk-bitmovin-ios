#!/bin/bash
set -euo pipefail

cd MUXSDKBitmovin
pod repo update
pod deintegrate && pod install
cd ..
PROJECT=MUXSDKBitmovin/MUXSDKBitmovin.xcworkspace

xcodebuild clean test \
  -workspace $PROJECT \
  -scheme MUXSDKBitmovin \
  -destination 'platform=iOS Simulator,name=iPhone 11,OS=15.0' \
