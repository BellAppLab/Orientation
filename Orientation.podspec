Pod::Spec.new do |s|
  s.name             = "Orientation"
  s.version          = "0.2.0"
  s.summary          = "A Swifty way to deal with and normalize orientations on iOS."

  s.description      = <<-DESC
A Swifty way to deal with and normalize orientations on iOS. Deals with Device, Interface, Image and (optionally) Video orientations.
                       DESC

  s.homepage         = "https://github.com/BellAppLab/Orientation"
  s.license          = 'MIT'
  s.author           = { "Bell App Lab" => "apps@bellapplab.com" }
  s.source           = { :git => "https://github.com/BellAppLab/Orientation.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/BellAppLab'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.default_subspec = 'Core'
  s.frameworks = 'UIKit'

  s.subspec 'Core' do |sp|
    sp.source_files = 'Pod/Classes/Orientation.swift'
  end

  s.subspec 'Video' do |sp|
    sp.dependency 'Orientation/Core'
    sp.source_files = 'Pod/Classes/Video/*.{swift}'
    sp.frameworks = 'AVFountation'
  end

  s.subspec 'All' do |sp|
    sp.dependency 'Orientation/Core'
    sp.dependency 'Orientation/Video'
  end

end
