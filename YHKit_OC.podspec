#
#  Be sure to run `pod spec lint YHKit_OC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "YHKit_OC"
  s.version      = "0.0.1"
  s.summary      = "个人开发库、各种工具、类库、总结等"

  

  s.homepage     = "https://github.com/liujunliuhong/YHKit_OC"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "liujun" => "1035841713@qq.com" }
  # Or just: s.author    = "liujun"
  # s.authors            = { "liujun" => "1035841713@qq.com" }
  # s.social_media_url   = "http://twitter.com/liujun"


  # s.platform     = :ios
  s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/liujunliuhong/YHKit_OC.git", :tag => "#{s.version}" }


  s.source_files  = "YHKit_OC/YHKit_OC"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "Foundation"
  # s.frameworks = "Security", "SystemConfiguration", "CoreTelephony", "CommonCrypto", "AVFoundation", "Photos", "Contacts", "AddressBook", "LocalAuthentication"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependencys = "AFNetworking","MBProgressHUD", "SDAutoLayout", "Masonry"
  s.dependency "AFNetworking"
  s.dependency "MBProgressHUD"
  s.dependency "SDAutoLayout"
  s.dependency "Masonry"

end
