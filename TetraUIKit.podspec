Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "TetraUIKit"
  spec.version      = "0.0.1"
  spec.summary      = "A wrapper around UIKit to make view creation and layout setup more declarative and look more like Swift UI."

  spec.description  = <<-DESC
  This library allows UIKit view creation with declarative syntax. With this lib, you don't need to deal with storyboard anymore.
                   DESC

  spec.homepage     = "https://github.com/son-iOS/TetraUIKit"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "Son Nguyen" => "ndson040496@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.ios.deployment_target = "13.0"
  spec.osx.deployment_target = "11"
  spec.swift_versions = "5"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/son-iOS/TetraUIKit.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "TetraUIKit", "Sources/TetraUIKit/**/*.{swift}"
  spec.public_header_files = "Sources/TetraUIKit/**/TetraUIKit.h"

end
