Pod::Spec.new do |s|
    s.name              = 'mdk'
    s.version           = '0.35.1'
    s.summary           = 'Multimedia Development Kit'
    s.homepage          = 'https://github.com/wang-bin/mdk-sdk'

    s.author            = { 'Wang Bin' => 'wbsecg1@gmail.com' }
    s.license           = { :type => 'Commercial', :text => <<-LICENSE
    Copyright 2020-2025 WangBin
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
  LICENSE
        }

    s.platform          = :osx, :ios, :tvos, :visionos
    s.source            = { :http => 'https://sourceforge.net/projects/mdk-sdk/files/nightly/mdk-sdk-apple.tar.xz' }
    s.vendored_frameworks = 'mdk-sdk/lib/mdk.xcframework'
#    s.osx.vendored_libraries = 'mdk-sdk/lib/mdk.xcframework/macos-arm64_x86_64/mdk.framework/Versions/A/libffmpeg.7.dylib', 'mdk-sdk/lib/mdk.xcframework/macos-arm64_x86_64/mdk.framework/Versions/A/libass.dylib', 'mdk-sdk/lib/mdk.xcframework/macos-arm64_x86_64/mdk.framework/Versions/A/libmdk-braw.dylib', 'mdk-sdk/lib/mdk.xcframework/macos-arm64_x86_64/mdk.framework/Versions/A/libmdk-r3d.dylib'
    s.osx.deployment_target = '10.13'
    s.ios.deployment_target = '12.0'
    s.tvos.deployment_target = '12.0'
    s.visionos.deployment_target = '1.0'
    s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=*simulator*]' => 'i386'}
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=*simulator*]' => 'i386'}
    s.visionos.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=*simulator*]' => 'x86_64'} # optional?
    s.visionos.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=*simulator*]' => 'x86_64'}
#    s.user_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' }
#    s.pod_target_xcconfig = { 'VALID_ARCHS[sdk=iphonesimulator*]' => '' } # VALID_ARCHS is removed in xcode12.0
    #s.pod_target_xcconfig = { 'ARCHS[sdk=iphonesimulator*]' => '$(ARCHS_STANDARD_64_BIT)' }
end
