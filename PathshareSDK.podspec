Pod::Spec.new do |s|
  s.name                  = 'PathshareSDK'
  s.version               = '2.3.3'
  s.summary               = 'The Pathshare iOS SDK, for integrating realtime location sharing capabilities into your iOS application.'
  s.license               = { :type => "Apache license", :file => "LICENSE" }
  s.authors               = {"Jaro Habr"=>"jaro@freshbits.ch", "Thomas Maurer"=>"thomas@freshbits.ch", "Stefan Schurgast"=>"stefan@freshbits.ch"}
  s.homepage              = 'https://github.com/freshbits/pathshare-sdk-ios'
  s.description           = 'The Pathshare iOS SDK, for integrating realtime location sharing capabilities into your iOS application. The SDK supports iOS 10 and later.'
  s.frameworks            = ["Foundation", "UIKit", "CoreLocation"]
  s.requires_arc          = true
  s.source                = { :git => 'https://github.com/freshbits/pathshare-sdk-ios.git', :tag => s.version.to_s }
  s.platform              = :ios, '12.0'
  s.preserve_paths        = 'PathshareSDK.xcframework'
  s.vendored_frameworks   = 'PathshareSDK.xcframework'
  s.pod_target_xcconfig   = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig  = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end