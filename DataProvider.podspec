#
# Be sure to run `pod lib lint DataProvider.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DataProvider"
  s.version          = "2.0.0"
  s.summary          = "Data provider is a library made to abstract Table and Collection views boilerplate code. It's all made in Swift!"

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  

  s.homepage         = "https://github.com/samsao/DataProvider.git"
  s.license          = 'MIT'
  s.author           = { "Guilherme Lisboa" => "glisboa@samsaodev.com" }
  s.source           = { :git => "https://github.com/samsao/DataProvider.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

end
