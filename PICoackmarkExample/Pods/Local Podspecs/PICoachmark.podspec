Pod::Spec.new do |s|

# Root specification

  s.name         = "PICoachmark"
  s.version      = "0.0.1"
  s.summary      = "Easy to use and customizable coach mark library"
  s.homepage     = ""
  s.author       = { "Jack" => "psyquy@gmail.com" }
  s.source       = {:git => 'https://github.com/phamquy/PICoachmark.git'}
  
# Build setting
  s.dependency 'AnimatedGIFImageSerialization', '~> 0.2'
  s.ios.deployment_target = '7.0'
  s.platform = :ios, '7.0' 
  s.framework  = 'UIKit'
  s.requires_arc = true
  s.public_header_files = 'PICoachmark/*.h'
  s.source_files  = 'PICoachmark/**/*.{h,m}'
end