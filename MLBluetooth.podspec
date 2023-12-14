Pod::Spec.new do |s|  
    s.name              = 'MLBluetooth'
    s.version           = '4.0.0'
    s.summary           = 'Master Lock Bluetooth SDK for Connected Products'
    s.homepage          = ''
    s.license           = { :type => 'Custom', :file => 'LICENSE' }
    s.authors           = 'The Master Lock Company'
    s.platform          = :ios

    s.source            = { :git => "https://github.com/pssplgithub/MLBluetoothSDK-iOS.git", :tag => s.version.to_s }

    s.swift_version = "5.3"

    s.ios.deployment_target = '13.0'
    s.ios.vendored_frameworks = 'MLBluetooth.xcframework'

    s.watchos.deployment_target = '7.0'
    s.watchos.vendored_frameworks = 'MLBluetooth.xcframework'
end