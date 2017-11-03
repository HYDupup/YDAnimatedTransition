
Pod::Spec.new do |s|
  
  s.name         = "YDAnimatedTransition"
  s.version      = "0.0.1"
  s.summary      = "time of button"
  s.homepage     = "https://github.com/HYDupup/YDAnimatedTransition"
  s.license      = "MIT"
  s.author             = { "Huangupup" => "757345969@qq.com" }
  s.source       = { :git => "https://github.com/HYDupup/YDAnimatedTransition.git", :tag => "#{s.version}" }
  s.requires_arc = true
  s.ios.deployment_target = "7.0"
  s.source_files  = "YDAnimatedTransition/**/*"
end