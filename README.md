![SRG Logger logo](README-images/logo.png)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)

## About

## Compatibility

The library is suitable for applications running on iOS 8 and above. The project is meant to be opened with the latest Xcode version (currently Xcode 8).

## Installation

The library can be added to a project using [Carthage](https://github.com/Carthage/Carthage)  by adding the following dependency to your `Cartfile`:
    
```
github "SRGSSR/srgappearance-ios"
```

Then run `carthage update` to update the dependencies. You will need to manually add the `SRGAppearance.framework` generated in the `Carthage/Build/iOS` folder to your project.

For more information about Carthage and its use, refer to the [official documentation](https://github.com/Carthage/Carthage).

## Usage

When you want to use classes or functions provided by the library in your code, you must import it from your source files first.

### Usage from Objective-C source files

Import the global header file using:

```objective-c
#import <SRGAppearance/SRGAppearance.h>
```

or directly import the module itself:

```objective-c
@import SRGAppearance;
```

### Usage from Swift source files

Import the module where needed:

```swift
import SRGAppearance
```

## License

See the [LICENSE](LICENSE) file for more information.



