#
# Be sure to run `pod lib lint SERichTextEditor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SERichTextEditor'
  s.version          = '1.0.0'
  s.summary          = 'Rich text editor.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "Rich text editor for iOS"

  s.homepage         = 'https://github.com/seeEmil/SERichTextEditor'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'seeEmil' => '864009759@qq.com' }
  s.source           = { :git => 'https://github.com/seeEmil/SERichTextEditor.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'SERichTextEditor/Classes/**/*'
  
   s.resource_bundles = {
     'SERichTextEditor' => [
     'SERichTextEditor/Assets/*.png',
     'SERichTextEditor/Classes/richText/webSource/*'
     ]
  }
end
