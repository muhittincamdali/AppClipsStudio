Pod::Spec.new do |s|
  s.name             = 'AppClipsStudio'
  s.version          = '1.0.0'
  s.summary          = 'Complete App Clips development toolkit for iOS with instant experiences.'
  s.description      = <<-DESC
    AppClipsStudio provides everything you need to build App Clips for iOS.
    Features include App Clip Card configuration, invocation handling, location
    verification, size optimization, and seamless full app transitions.
  DESC

  s.homepage         = 'https://github.com/muhittincamdali/AppClipsStudio'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Muhittin Camdali' => 'contact@muhittincamdali.com' }
  s.source           = { :git => 'https://github.com/muhittincamdali/AppClipsStudio.git', :tag => s.version.to_s }

  s.ios.deployment_target = '14.0'

  s.swift_versions = ['5.9', '5.10', '6.0']
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'Foundation', 'SwiftUI', 'AppClip'
end
