//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearance
import SwiftUI

public extension SRGFont {
    /**
     *  Font with a predefined style. The font scales according to an internally associated matching text style and the
     *  current accessibility settings. A maximum size can optionally be provided.
     */
    static func font(_ style: SRGFont.Style, maximumSize: CGFloat? = nil) -> UIFont {
        if let maximumSize = maximumSize {
            return __font(with: style, maximumSize: maximumSize)
        }
        else {
            return __font(with: style)
        }
    }
    
    /**
     *  Font with a given family, weight and size. The font scales relative to the provided text style and the current
     *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large` setting.
     */
    static func font(family: SRGFont.Family = .text, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> UIFont {
        if let maximumSize = maximumSize {
            return __font(with: family, weight: weight, size: size, maximumSize: maximumSize, relativeToTextStyle: textStyle)
        }
        else {
            return __font(with: family, weight: weight, size: size, relativeToTextStyle: textStyle)
        }
    }
    
    /**
     *  Font with a given family, weight and fixed size. Does not scale with accessibility settings.
     */
    static func font(family: SRGFont.Family = .text, weight: UIFont.Weight, fixedSize: CGFloat) -> UIFont {
        return __font(with: family, weight: weight, fixedSize: fixedSize)
    }
}

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension SRGFont {
    /**
     *  Font with a predefined style. The font scales according to an internally associated matching text style and the
     *  current accessibility settings. A maximum size can optionally be provided.
     */
    static func font(_ style: SRGFont.Style, maximumSize: CGFloat? = nil) -> Font {
        return Font(font(style, maximumSize: maximumSize))
    }
    
    /**
     *  Font with a given family, weight and size. The font scales relative to the provided text style and the current
     *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large` setting.
     */
    static func font(family: SRGFont.Family = .text, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> Font {
        return Font(font(family: family, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
    }
    
    /**
     *  Font with a given family, weight and fixed size. Does not scale with accessibility settings.
     */
    static func font(family: SRGFont.Family = .text, weight: UIFont.Weight, fixedSize: CGFloat) -> Font {
        return Font(font(family: family, weight: weight, fixedSize: fixedSize))
    }
}

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension Text {
    /**
     *  Wrapper class to observe content size category changes. Fonts created with `Font.custom(...)` initializers
     *  namely automatically reload `Text` displaying them, while this is not the case for fonts created with
     *  `Font.init()`.
     */
    // TODO: If content size changes are automatically tracked for texts using custom fonts in future SwiftUI versions,
    //       remove this wrapper and return `Text` instead of `some View` from modifiers.
    private struct SizeCategoryTracker<Content: View>: View {
        private let content: () -> Content
        
        @Environment(\.sizeCategory) private var sizeCategory
        
        init(content: @escaping () -> Content) {
            self.content = content
        }
        
        var body: some View {
            content()
        }
    }
    
    /**
     *  Applies a font with a predefined style to the receiver. The font scales according to an internally associated
     *  matching text style and the current accessibility settings.
     */
    func srgFont(_ style: SRGFont.Style, maximumSize: CGFloat? = nil) -> some View {
        return SizeCategoryTracker {
            font(SRGFont.font(style, maximumSize: maximumSize))
        }
    }
    
    /**
     *  Applies a font with a given family, weight and size to the receiver. The font scales relative to the provided text
     *  style and the current accessibility settings, starting from the specified size. A maximum size can optionally be
     *  provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large` setting.
     */
    func srgFont(family: SRGFont.Family = .text, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> some View {
        return SizeCategoryTracker {
            font(SRGFont.font(family: family, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
        }
    }
    
    /**
     *  Applies a font with a given family, weight and fixed size to the receiver. Does not scale with accessibility settings.
     */
    func srgFont(family: SRGFont.Family = .text, weight: UIFont.Weight, fixedSize: CGFloat) -> some View {
        return SizeCategoryTracker {
            font(SRGFont.font(family: family, weight: weight, fixedSize: fixedSize))
        }
    }
}

@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
extension ScaledMetric {
    private static func textStyle(from style: UIFont.TextStyle) -> Font.TextStyle {
        switch style {
        #if os(iOS)
        case .largeTitle:
            return .largeTitle
        #endif
        case .title1:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption1:
            return .caption
        case .caption2:
            return .caption2
        default:
            return .body
        }
    }
    
    /**
     *  Scales the wrapped value based on the text style associated with the font style.
     */
    public init(wrappedValue: Value, with style: SRGFont.Style) {
        let textStyle = Self.textStyle(from: SRGFont.textStyle(for: style))
        self.init(wrappedValue: wrappedValue, relativeTo: textStyle)
    }
}
