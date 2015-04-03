Pod::Spec.new do |s|

  s.name             = "HorizontalTableView"
  s.version          = "1.0.0"
  s.summary          = "A UITableView that scrolls horizontally / sideways"
  s.homepage         = "https://github.com/JamieREvans/HorizontalTableView"
  s.license          = 'MIT'
  s.author           = { "Jamie Riley Evans" => "jamie.riley.evans@gmail.com" }
  s.source           = { :git => "https://github.com/JamieREvans/HorizontalTableView.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.dependency 'UIKitPlus', '~> 1.0.0'
	
end
