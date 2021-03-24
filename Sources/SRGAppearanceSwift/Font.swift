//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearance
import SwiftUI

public extension SRGFont {
    /**
     *  Font with a given type and predefined style. The font scales according to an internally associated matching text style
     *  and the current accessibility settings.
     */
    static func font(_ type: SRGFont.`Type`, style: SRGFont.Style) -> UIFont {
        return __font(with: type, style: style)
    }
    
    /**
     *  Font with a given type, weight and size. The font scales relative to the provided text style and the current
     *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large`
     *              setting.
     */
    static func font(_ type: SRGFont.`Type`, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> UIFont {
        if let maximumSize = maximumSize {
            return __font(with: type, weight: weight, size: size, maximumSize: maximumSize, relativeToTextStyle: textStyle)
        }
        else {
            return __font(with: type, weight: weight, size: size, relativeToTextStyle: textStyle)
        }
    }
    
    /**
     *  Font with a given type, weight and fixed size. Does not scale with accessibility settings.
     */
    static func font(_ type: SRGFont.`Type`, weight: UIFont.Weight, fixedSize: CGFloat) -> UIFont {
        return __font(with: type, weight: weight, fixedSize: fixedSize)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension SRGFont {
    /**
     *  Font with a given type and predefined style. The font scales according to an internally associated matching text style
     *  and the current accessibility settings.
     */
    static func font(_ type: SRGFont.`Type`, style: SRGFont.Style) -> Font {
        return Font(font(type, style: style))
    }
    
    /**
     *  Font with a given type, weight and size. The font scales relative to the provided text style and the current
     *  accessibility settings, starting from the specified size. A maximum size can optionally be provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large`
     *              setting.
     */
    static func font(_ type: SRGFont.`Type`, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> Font {
        return Font(font(type, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
    }
    
    /**
     *  Font with a given type, weight and fixed size. Does not scale with accessibility settings.
     */
    static func font(_ type: SRGFont.`Type`, weight: UIFont.Weight, fixedSize: CGFloat) -> Font {
        return Font(font(type, weight: weight, fixedSize: fixedSize))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension Text {
    /**
     *  Applies a font with a given type and predefined style to the receiver. The font scales according to an internally
     *  associated matching text style and the current accessibility settings.
     */
    func srgFont(_ type: SRGFont.`Type`, style: SRGFont.Style) -> Text {
        return font(SRGFont.font(type, style: style))
    }
    
    /**
     *  Applies a font with a given type, weight and size to the receiver. The font scales relative to the provided text
     *  style and the current accessibility settings, starting from the specified size. A maximum size can optionally be
     *  provided.
     *
     *  @discussion The reference `size` parameter corresponds to the `UIContentSizeCategory.large`
     *              setting.
     */
    func srgFont(_ type: SRGFont.`Type`, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> Text {
        return font(SRGFont.font(type, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
    }
    
    /**
     *  Applies a font with a given type, weight and fixed size to the receiver. Does not scale with accessibility settings.
     */
    func srgFont(_ type: SRGFont.`Type`, weight: UIFont.Weight, fixedSize: CGFloat) -> Text {
        return font(SRGFont.font(type, weight: weight, fixedSize: fixedSize))
    }
}

// TODO:
//  - Swift UI API (font modifiers + @ScaledMetric relative to SRG styles; if not possible, expose conversion
//    from SRG style to text style and remove metrics static method since not useful anymore)
