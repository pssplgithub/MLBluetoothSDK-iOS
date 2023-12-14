# <img src="https://enterprise.masterlockvault.com/Images/4400D.svg" width="48" height="48"> MLBluetoothSDK for iOS

## Requirements

- Xcode 13.x
- Swift 5.x

Please review the [changelog](https://sdkdocs.masterlockvault.com/ios/documentation/mlbluetooth/changelog) after each release.

## Documentation

- [General Documentation](https://sdkdocs.masterlockvault.com)
- [iOS Documentation](https://sdkdocs.masterlockvault.com/ios/documentation/)

## Installation

Regardless of the installation method used, the following keys must be added to the project's Info.plist:

- NSLocationWhenInUseUsageDescription
- NSBluetoothAlwaysUsageDescription

MLBluetooth does not depend on any other 3rd party libraries.

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

At the top of your project's Podfile, add the following:

```ruby
source 'https://github.com/TMLC-Connected-Products/Specs'
source 'https://github.com/CocoaPods/Specs.git'
```

Add the dependency to the appropriate target within your Podfile:

```ruby
pod 'MLBluetooth'
```

You can add MLBluetooth to your WatchOS app target by specifiying the platform:

```ruby
target 'Watch' do
    platform :watchos, '7.0'
    pod 'MLBluetooth'
end
```

> Note: When MLBluetooth is being installed, git will ask for your credentials in the command line. You will need to use a personal access token for your password because Github no longer supports password authentication via the terminal.

### Manually

1. Download the MLBluetooth.xcframework file.
1. Drag the MLBluetooth.xcframework into your Xcode Project.
1. Select your project’s main .xcodeproj directory and select the main target.
1. Select the General tab and ensure that MLBluetooth.xcframework is included in the "Frameworks, Libraries, and Embedded Content" section. Ensure it is set to "Embed & Sign."
