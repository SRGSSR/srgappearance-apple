![SRG Appearance logo](README-images/logo.png)

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)

## About

SRG Appearance is a lightweight library providing unified SRG SSR appearance to iOS and tvOS applications:

* Official SRG SSR fonts, automatically registered with your application, and with standard point sizes for common text styles.
* Official SRG SSR colors.
* Image processing tools.

## Compatibility

The library is suitable for applications running on iOS 9, tvOS 9 and above. The project is meant to be opened with the latest Xcode version (currently Xcode 10).

## Contributing

If you want to contribute to the project, have a look at our [contributing guide](CONTRIBUTING.md).

## Installation

The library can be added to a project using [Carthage](https://github.com/Carthage/Carthage) by adding the following dependency to your `Cartfile`:
    
```
github "SRGSSR/srgappearance-ios"
```

For more information about Carthage and its use, refer to the [official documentation](https://github.com/Carthage/Carthage).

### Dependencies

The library requires the following frameworks to be added to any target requiring it:

* `SRGAppearance `: The main library framework.

### Dynamic framework integration

1. Run `carthage update` to update the dependencies (which is equivalent to `carthage update --configuration Release`). 
2. Add the frameworks listed above and generated in the `Carthage/Build/(iOS|tvOS)` folder to your target _Embedded binaries_.

If your target is building an application, a few more steps are required:

1. Add a _Run script_ build phase to your target, with `/usr/local/bin/carthage copy-frameworks` as command.
2. Add each of the required frameworks above as input file `$(SRCROOT)/Carthage/Build/(iOS|tvOS)/FrameworkName.framework`.

### Static framework integration

1. Run `carthage update --configuration Release-static` to update the dependencies. 
2. Add the frameworks listed above and generated in the `Carthage/Build/(iOS|tvOS)/Static` folder to the _Linked frameworks and libraries_ list of your target.
3. Also add any resource bundle `.bundle` found within the `.framework` folders to your target directly.
4. Add the `-all_load` flag to your target _Other linker flags_.

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

## Building the project

A [Makefile](../Makefile) provides several targets to build and package the library. The available targets can be listed by running the following command from the project root folder:

```
make help
```

Alternatively, you can of course open the project with Xcode and use the available schemes.

## SRG SSR fonts

Two sets of font methods are provided in `UIFont+SRGAppearance.h`:

* Methods returning a font with a given size. You can also set fonts with a given size directly in Interface Builder. Simply install the fonts available in `Carthage/Checkouts/(iOS|tvOS)/srgappearance-ios/Framework/Resources/Fonts` by double-clicking on them first.
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



