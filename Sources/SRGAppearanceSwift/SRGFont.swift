//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearance
import SwiftUI

extension SRGFont {
    static func font(_ type: SRGFontType, style: SRGFontStyle) -> UIFont {
        return __font(with: type, style: style)
    }
    
    static func font(_ type: SRGFontType, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> UIFont {
        if let maximumSize = maximumSize {
            return __font(with: type, weight: weight, size: size, maximumSize: maximumSize, relativeToTextStyle: textStyle)
        }
        else {
            return __font(with: type, weight: weight, size: size, relativeToTextStyle: textStyle)
        }
    }
    
    static func font(_ type: SRGFontType, weight: UIFont.Weight, fixedSize: CGFloat) -> UIFont {
        return __font(with: type, weight: weight, fixedSize: fixedSize)
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension SRGFont {
    static func font(_ type: SRGFontType, style: SRGFontStyle) -> Font {
        return Font(font(type, style: style))
    }
    
    static func font(_ type: SRGFontType, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> Font {
        return Font(font(type, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
    }
    
    static func font(_ type: SRGFontType, weight: UIFont.Weight, fixedSize: CGFloat) -> Font {
        return Font(font(type, weight: weight, fixedSize: fixedSize))
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension Text {
    func srgFont(_ type: SRGFontType, style: SRGFontStyle) -> Text {
        return font(SRGFont.font(type, style: style))
    }
    
    func srgFont(_ type: SRGFontType, weight: UIFont.Weight, size: CGFloat, maximumSize: CGFloat? = nil, relativeTo textStyle: UIFont.TextStyle = .body) -> Text {
        return font(SRGFont.font(type, weight: weight, size: size, maximumSize: maximumSize, relativeTo: textStyle))
    }
    
    func srgFont(_ type: SRGFontType, weight: UIFont.Weight, fixedSize: CGFloat) -> Text {
        return font(SRGFont.font(type, weight: weight, fixedSize: fixedSize))
    }
}

// TODO:
//  - Test that the Swift API can be used properly (Swift UT)
//  - Swift UI API (font modifiers + @ScaledMetric relative to SRG styles; if not possible, expose conversion
//    from SRG style to text style and remove metrics static method since not useful anymore)
