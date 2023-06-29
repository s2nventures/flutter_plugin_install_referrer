#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint install_referrer.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'install_referrer'
  s.version          = '1.0.0'
  s.summary          = 'Detect from where your application was installed (Google Play, App Store, TestFlight…)'
  s.description      = <<-DESC
Detect from where your application was installed (Google Play, App Store, TestFlight…)
                       DESC
  s.homepage         = 'https://daad.mobi'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'DAAD' => 'moi@edouard-marquez.me' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.platform = :osx, '10.11'

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
