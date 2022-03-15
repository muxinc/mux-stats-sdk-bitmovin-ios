## How to release
1. Bump version in Mux-Stats-Bitmovin.podspec
2. Bump version in XCode "General" for target: MUXSDKBitmovin
3. Bump version in XCode "General" for target: MUXSDKBitmovinTv
4. Push to your release branch in Github
5. Download artifact from the Build step of the Github pipeline
Make sure this is from the latest commit on your branch. 
7. Unzip the file and copy the resulting `MUXSDKBitmovin.xcframework` into `XCFramework`and commit this.
8. Github - Create a PR to check in all changed files.
9. If approved, squash & merge into main
10. Pull main locally and `git tag [YOUR NEW VERSION]` and `git push --tags`
11. Cocoapod - Run `pod spec lint` to local check pod validity
12. Cocoapod - Run `pod trunk push Mux-Stats-Bitmovin.podspec`
13. Github UI - Make a new release with the new version. Attach the XCFramework artifacts from the automated build to the release.
14. Update the release notes in the [Bitmovin Integration Guide](https://docs.mux.com/guides/data/monitor-bitmovin-ios)

After release:

* Try the new version to the sample app in this repo.
