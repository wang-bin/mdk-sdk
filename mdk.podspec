Pod::Spec.new do |s|
    s.name              = 'mdk'
    s.version           = '0.22.0'
    s.summary           = 'Multimedia Development Kit'
    s.homepage          = 'https://github.com/wang-bin/mdk-sdk'

    s.author            = { 'Wang Bin' => 'wbsecg1@gmail.com' }
    s.license           = { :type => 'MIT', :text => <<-LICENSE
    Copyright 2020 WangBin
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  LICENSE
        }

    s.platform          = :osx, :ios
    s.source            = { :http => 'https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-apple.tar.xz' }
    s.vendored_frameworks = 'mdk-sdk/lib/mdk.xcframework'
    s.osx.deployment_target = '10.13'
#    s.osx.vendored_libraries = 'mdk-sdk/lib/FFmpeg.xcframework/macos-arm64_x86_64/libffmpeg.6.dylib'
    s.ios.deployment_target = '11.0'
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'}
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386', 'OTHER_CODE_SIGN_FLAGS' => '$(inherited) --deep'}
#    s.user_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' }
#    s.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' } # VALID_ARCHS is removed in xcode12.0
    #s.pod_target_xcconfig = { 'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)' }
end
