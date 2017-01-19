#
# Be sure to run `pod lib lint PYOpenShare.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PYOpenShare'
  s.version          = '0.1.0'
  s.summary          = 'A social module based on Openshare contributing to sharing infomation with kinds of platforms such as Weixin , Weibo , tencent ,etc ,which also contribute to OAuth and Pay '

  s.description      = <<-DESC
    This a social module based on Openshare contributing to sharing infomation with kinds of platforms such as Weixin , Weibo , tencent ,etc ,which also contribute to OAuth and Pay.You can follow this order :
    Abount specific instructions , you can refer to example.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/PYOpenShare'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'MikeZhangpy' => 'zhangpy1991@126.com' }
  s.source           = { :git => 'https://github.com/<GITHUB_USERNAME>/PYOpenShare.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.default_subspecs = 'Open'

  s.subspec 'Open' do |ss|
    ss.dependency 'PYOpenShare/Tool'
    ss.dependency 'PYOpenShare/View'
    ss.source_files = 'PYOpenShare/OpenShare/*'
  end

  s.subspec 'Tool' do |ss|
    ss.source_files = 'PYOpenShare/OpenShareTool/*'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'PYOpenShare/OpenShareView/*'
  end
end
