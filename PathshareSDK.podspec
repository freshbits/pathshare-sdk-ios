Pod::Spec.new do |s|
  s.name                = 'PathshareSDK'
  s.version             = '1.0.1'
  s.summary             = 'The Pathshare iOS SDK, for integrating realtime location sharing capabilities into your iOS application.'
  s.license             = { :type => "Apache license", :file => "LICENSE" }
  s.authors             = {"Jaro Habr"=>"jaro@freshbits.ch", "Thomas Maurer"=>"thomas@freshbits.ch", "Stefan Schurgast"=>"stefan@freshbits.ch"}
  s.homepage            = 'https://github.com/freshbits/pathshare-sdk-ios'
  s.description         = 'The Pathshare iOS SDK, for integrating realtime location sharing capabilities into your iOS application. The SDK supports iOS 8 and iOS 9.'
  s.frameworks          = ["Foundation", "UIKit", "CoreLocation"]
  s.requires_arc        = true
  s.source              = { :git => 'https://github.com/freshbits/pathshare-sdk-ios.git', :tag => s.version.to_s }
  s.platform            = :ios, '8.0'
  s.preserve_paths      = 'PathshareSDK.framework'
  s.public_header_files = 'PathshareSDK.framework/Headers/PathshareSDK.h'
  s.vendored_frameworks = 'PathshareSDK.framework'
end