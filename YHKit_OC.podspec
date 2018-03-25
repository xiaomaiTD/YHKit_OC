#
#  Be sure to run `pod spec lint YHKit_OC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "YHKit_OC"
  s.version      = "0.0.5"
  s.summary      = "个人开发库、各种工具、类库、总结等"

  

  s.homepage     = "https://github.com/liujunliuhong/YHKit_OC"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "liujun" => "1035841713@qq.com" }

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/liujunliuhong/YHKit_OC.git", :tag => "#{s.version}" }


  # 资源文件
  s.resources    = 'YHKit_OC/YHKit_OC/Album/*.{strings,xcassets},YHKit_OC/YHKit_OC/CustomNaviBar/YHNavigation.bundle'
  s.source_files  = "YHKit_OC/YHKit_OC/**/*.{h,m}"
  # s.source_files  = "YHKit_OC/YHKit_OC/YHKit_OC.h"
  # s.public_header_files = "YHKit_OC/YHKit_OC/YHKit_OC.h"

  # s.subspec 'Album' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Album/**/*.{h,m}'
  # end
  # s.subspec 'Alert' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Alert/**/*.{h,m}'
  # end
  # s.subspec 'Authorization' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Authorization/**/*.{h,m}'
  # end
  # s.subspec 'CustomNaviBar' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/CustomNaviBar/**/*.{h,m}'
  # end
  # s.subspec 'Data_Category' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Data_Category/**/*.{h,m}'
  # end
  # s.subspec 'Device' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Device/**/*.{h,m}'
  # end
  # s.subspec 'Drawer' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Drawer/**/*.{h,m}'
  # end
  # s.subspec 'Image_Category' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Image_Category/**/*.{h,m}'
  # end
  # s.subspec 'Macro' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Macro/**/*.{h,m}'
  # end
  # s.subspec 'MB_HUD' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/MB_HUD/**/*.{h,m}'
  # end
  # s.subspec 'Network' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/Network/**/*.{h,m}'
  # end
  # s.subspec 'String_Category' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/String_Category/**/*.{h,m}'
  # end
  # s.subspec 'SystemPhoto' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/SystemPhoto/**/*.{h,m}'
  # end
  # s.subspec 'DataSecurity' do |ss|
  #   ss.source_files = 'YHKit_OC/YHKit_OC/DataSecurity/**/*.{h,m}'
  # end

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


  # s.dependency "AFNetworking"
  # s.dependency "MBProgressHUD"
  # s.dependency "SDAutoLayout"
  # s.dependency "Masonry"
  # s.dependency "FDFullscreenPopGesture"

end
