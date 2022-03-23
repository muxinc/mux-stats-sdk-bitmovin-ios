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

################ Build MuxBitmovin SDK

xcodebuild archive -scheme MUXSDKBitmovinTv -workspace $PROJECT -destination "generic/platform=tvOS" -archivePath "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DIS\
TRIBUTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib || clean_up_error
xcodebuild archive -scheme MUXSDKBitmovinTv -workspace $PROJECT -destination "generic/platform=tvOS Simulator" -archivePath "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive" SKIP_INSTALL=NO \
BUILD_LIBRARY_FOR_DISTRIBUTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib || clean_up_error
xcodebuild archive -scheme MUXSDKBitmovin -workspace $PROJECT  -destination "generic/platform=iOS" -archivePath "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive" SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIB\
UTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib || clean_up_error
xcodebuild archive -scheme MUXSDKBitmovin -workspace $PROJECT  -destination "generic/platform=iOS Simulator" -archivePath "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive" SKIP_INSTALL=NO BUILD\
_LIBRARY_FOR_DISTRIBUTION=YES CLANG_ENABLE_MODULES=NO MACH_O_TYPE=staticlib || clean_up_error

 xcodebuild -create-xcframework -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovinTv.tvOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -framework "$BUILD_DIR/MUXSDKBitmovin.iOS-simulator.xcarchive/Products/Library/Frameworks/MUXSDKBitmovin.framework" \
                                -output "$TARGET_DIR/MUXSDKBitmovin.xcframework" || clean_up_error

rm -Rf $BUILD_DIR
