Pod::Spec.new do |s|
  s.name             = 'Mux-Stats-Bitmovin'

  s.version          = '0.1.0'
  s.source           = { :git => 'https://github.com/muxinc/mux-stats-sdk-bitmovin-ios.git',
                         :tag => "v#{s.version}" }

  s.summary          = 'The Mux Stats SDK for Bitmovin'
  s.description      = 'The Mux Stats SDK connect with Bitmovin player to perform analytics and QoS monitoring for video.'

  s.homepage         = 'https://mux.com'
  s.social_media_url = 'https://twitter.com/muxhq'

  s.license          = 'Apache 2.0'
  s.author           = { 'Mux' => 'ios-sdk@mux.com' }
  s.swift_version = '5.0'

  s.dependency 'Mux-Stats-Core', '~>3.5'
  s.dependency 'BitmovinPlayer'

  s.frameworks = 'AVFoundation', 'Network', 'SystemConfiguration'

  s.ios.deployment_target = '12.0'
  s.ios.vendored_frameworks = 'XCFramework/MUXSDKBitmovin.xcframework'

  s.tvos.deployment_target = '12.0'
  s.tvos.vendored_frameworks = 'XCFramework/MUXSDKBitmovin.xcframework'

  s.pod_target_xcconfig = {
    'BUILD_LIBRARY_FOR_DISTRIBUTION' => 'YES'
  }
end
