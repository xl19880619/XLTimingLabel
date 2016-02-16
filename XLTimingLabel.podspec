#
#  Be sure to run `pod spec lint XLTimingLabel.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "XLTimingLabel"
  s.version      = "0.0.1"
  s.summary      = "Increase/Decrease time label with formatter style."
  s.license      = "MIT"
  s.homepage     = "https://github.com/xl19880619/XLTimingLabel"
  s.license      = "MIT"
  s.author       = { "Xie Lei" => "xl19880619@gmail.com" }
  s.platform     = :ios, "5.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/xl19880619/XLTimingLabel.git", :tag => "0.0.1" }


  s.source_files  = "TimingLabel/**/*.{h,m}"

  # s.requires_arc = true
end
