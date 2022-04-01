BUILD_DIR=$PWD/MUXSDKBitmovin/xc
PROJECT=$PWD/MUXSDKBitmovin/MUXSDKBitmovin.xcworkspace
TARGET_DIR=$PWD/XCFramework


# Delete the old stuff
rm -Rf $TARGET_DIR

# Make the build directory
mkdir -p $BUILD_DIR
# Make the target directory
mkdir -p $TARGET_DIR

# Clean up on error
clean_up_error () {
    rm -Rf $BUILD_DIR
    exit 1
}

# Build and clean up on error
build () {
  scheme=$1
  destination="$2"
  path="$3"
  
  xcodebuild archive -scheme $scheme -workspace $PROJECT -destination "$destination" -archivePath "$path" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES || clean_up_error
}

################ Build MuxBitmovin SDK

build MUXSDKBitmovinTv "generic/platform=tvOS" "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive"
build MUXSDKBitmovinTv "generic/platform=tvOS Simulator" "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive"
build MUXSDKBitmovin "generic/platform=iOS" "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive"
build MUXSDKBitmovin "generic/platform=iOS Simulator" "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive"
  
 xcodebuild -create-xcframework -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -output "$TARGET_DIR/MUXSDKBitmovin.xcframework" || clean_up_error

rm -Rf $BUILD_DIR
