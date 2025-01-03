#
# Be sure to run `pod lib lint ACRadioPlayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ACRadioPlayer'
  s.version          = '0.3.0'
  s.summary          = 'A radio player for iOS/macOS/tvOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ACRadioPlayer is a wrapper around AVPlayer to handle internet radio playback.
                       DESC

  s.homepage         = 'https://github.com/joemcmahon/ACRadioPlayer'
  s.screenshots     = 'https://pemungkah.com/wp-content/uploads/2024/12/ACRadioPlayer_demo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Fethi El Hassasna' => 'e.fethi.c@gmail.com' }
  s.source           = { :git => 'https://github.com/joemcmahon/ACRadioPlayer.git', :tag => s.version.to_s }
  s.social_media_url = 'https://bsky.app/profile/equinoxdeschanel.bsky.social'

  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '10.15'
  s.tvos.deployment_target = '15'
  s.swift_version = '5.0'
  s.source = { :git => 'https://github.com/joemcmahon/ACRadioPlayer.git', :tag => s.version.to_s }
  s.source_files = 'Sources/**/*.swift'

  # s.resource_bundles = {
  #   'ACRadioPlayer' => ['Sources/ACRadioPlayer/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ACWebSocketClient', '~> 0.1.9'
  s.dependency 'Kingfisher', '~> 8.0'
end
