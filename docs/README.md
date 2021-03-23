[![SRG Appearance logo](README-images/logo.png)](https://github.com/SRGSSR/srgappearance-apple)

[![GitHub releases](https://img.shields.io/github/v/release/SRGSSR/srgappearance-apple)](https://github.com/SRGSSR/srgappearance-apple/releases) [![platform](https://img.shields.io/badge/platfom-ios%20%7C%20tvos-blue)](https://github.com/SRGSSR/srgappearance-apple) [![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://swift.org/package-manager) [![GitHub license](https://img.shields.io/github/license/SRGSSR/srgappearance-apple)](https://github.com/SRGSSR/srgappearance-apple/blob/master/LICENSE)

## About

SRG Appearance is a lightweight library providing unified SRG SSR appearance to iOS and tvOS applications:

* Official SRG SSR fonts, automatically registered with your application, and with standard point sizes for common text styles.
* Official SRG SSR colors.
* Image processing tools.

## Compatibility

The library is suitable for applications running on iOS 12, tvOS 12 and above. The project is meant to be compiled with the latest Xcode version.

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

Official SRG Fonts are available from the `SRGFont` class. In general you should use fonts scaling according to a given text style, as these correctly take into account system accessibility settings.

You can also register your own custom fonts at runtime by calling the `SRGAppearanceRegisterFont` function available from the same header file.

## SRG SSR text styles

A limited set of SRG SSR custom font styles is provided as well. SRG SSR fonts are readily compatible with those styles, and a method is provided to apply them to arbitrary fonts as well.

## SRG SSR colors

Standard colors are provided in `UIColor+SRGAppearance.h`.

## Image processing

Image processing tools are provided in `UIImage+SRGAppearance.h`.

## License

See the [LICENSE](../LICENSE) file for more information.



