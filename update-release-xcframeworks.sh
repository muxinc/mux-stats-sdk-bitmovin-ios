BUILD_DIR=$PWD/MUXSDKBitmovin/xc
PROJECT=$PWD/MUXSDKBitmovin/MUXSDKBitmovin.xcworkspace
TARGET_DIR=$PWD/XCFramework


# Delete the old stuff
rm -Rf $TARGET_DIR

# Make the build directory
mkdir -p $BUILD_DIR
# Make the target directory
mkdir -p $TARGET_DIR

################ Build MuxCore SDK

xcodebuild archive -scheme MUXSDKBitmovinTv -workspace $PROJECT -destination "generic/platform=tvOS" -archivePath "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
 xcodebuild archive -scheme MUXSDKBitmovinTv -workspace $PROJECT -destination "generic/platform=tvOS Simulator" -archivePath "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
 xcodebuild archive -scheme MUXSDKBitmovin -workspace $PROJECT  -destination "generic/platform=iOS" -archivePath "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
 xcodebuild archive -scheme MUXSDKBitmovin -workspace $PROJECT  -destination "generic/platform=iOS Simulator" -archivePath "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
  
 xcodebuild -create-xcframework -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -output "$TARGET_DIR/MUXSDKBitmovin.xcframework"

rm -Rf $BUILD_DIR
