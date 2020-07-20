[![SRG Appearance logo](README-images/logo.png)](https://github.com/SRGSSR/srgappearance-apple)

[![GitHub releases](https://img.shields.io/github/v/release/SRGSSR/srgappearance-apple)](https://github.com/SRGSSR/srgappearance-apple/releases) [![platform](https://img.shields.io/badge/platfom-ios%20%7C%20tvos-blue)](https://github.com/SRGSSR/srgappearance-apple) [![Build Status](https://travis-ci.org/SRGSSR/srgappearance-apple.svg?branch=master)](https://travis-ci.org/SRGSSR/srgappearance-apple/branches) [![GitHub license](https://img.shields.io/github/license/SRGSSR/srgappearance-apple)](https://github.com/SRGSSR/srgappearance-apple/blob/master/LICENSE)

## About

SRG Appearance is a lightweight library providing unified SRG SSR appearance to iOS and tvOS applications:

* Official SRG SSR fonts, automatically registered with your application, and with standard point sizes for common text styles.
* Official SRG SSR colors.
* Image processing tools.

## Compatibility

The library is suitable for applications running on iOS 9, tvOS 12 and above. The project is meant to be compiled with the latest Xcode version.

## Contributing

If you want to contribute to the project, have a look at our [contributing guide](CONTRIBUTING.md).

## Integration

The library must be integrated using [Swift Package Manager](https://swift.org/package-manager) directly [within Xcode](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app). You can also declare the library as a dependency of another one directly in the associated `Package.swift` manifest.

## Usage

When you want to use classes or functions provided by the library in your code, you must import it from your source files first. In Objective-C:

```objective-c
@import SRGAppearance;
```

or in Swift:

```swift
import SRGAppearance
```

## SRG SSR fonts

Two sets of font methods are provided in `UIFont+SRGAppearance.h`:

* Methods returning a font with a given size. You can also set fonts with a given size directly in Interface Builder. Simply install the fonts available in `Carthage/Checkouts/(iOS|tvOS)/srgappearance-apple/Framework/Resources/Fonts` by double-clicking on them first.
* Methods returning a font for a given text style. The exact font size is determined by the corresponding system accessibility setting. Setting custom fonts for a given style is sadly currently not supported in Interface Builder and must be performed in code.

You can also register your own custom fonts at runtime by calling the `SRGAppearanceRegisterFont` function available from the same header file.

## SRG SSR text styles

A limited set of SRG SSR custom font styles is provided as well. SRG SSR fonts are readily compatible with those styles, and a method is provided to apply them to arbitrary fonts as well.

## SRG SSR colors

Standard colors are provided in `UIColor+SRGAppearance.h`.

## Image processing

Image processing tools are provided in `UIImage+SRGAppearance.h`.

## License

See the [LICENSE](../LICENSE) file for more information.



