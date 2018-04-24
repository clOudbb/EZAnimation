Pod::Spec.new do |s|
  s.name         = 'EZAnimationObjc'
  s.summary      = 'An easy use of core animation kit'
  s.version      = '0.0.5'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'clOudbb' => 'z61723117@163.com' }
  s.social_media_url = 'https://github.com/clOudbb'
  s.homepage     = 'https://github.com/clOudbb/EZAnimation'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/clOudbb/EZAnimation.git', :tag => s.version }

  s.requires_arc = true
  s.source_files = 'Source/**/*.{h,m}'
  s.public_header_files = 'Source/**/*.{h}'

end
