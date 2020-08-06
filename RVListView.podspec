#
# Be sure to run `pod lib lint RVListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RVListView'
  s.version          = '1.0.0'
  s.summary          = 'RVListView is an UI compont that used for showing results.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RVListView is an UI compont that used for showing results. Feature: 1. dynamic cell width 2. unique properties for each cell 3. configureble margins 4. ease to use
                       DESC

  s.homepage         = 'https://github.com/dlfkid/RVListView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dlfkid' => 'dlfkid@icloud.com' }
  s.source           = { :git => 'https://github.com/dlfkid/RVListView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'RVListView/RVListView/**/*'

  s.public_header_files = 'RVListView/RVListView/**/*.h'

  s.pod_target_xcconfig = { 
    'ENABLE_BITCODE' => 'NO', 
    'CLANG_WARN_STRICT_PROTOTYPES' => 'NO',
    'STRIP_INSTALLED_PRODUCT' => 'NO', 
    'COPY_PHASE_STRIP' => 'NO',
    'VALID_ARCHS' => 'armv7 arm64 x86_64'
  }
end
