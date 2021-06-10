//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SwiftUI

/**
 *  A dynamic property that scales a numeric value, based on SRG SSR font styles (scaling curve, maximum value).
 */
@available(iOS 14, macOS 11, tvOS 14, watchOS 7, *)
@propertyWrapper public struct SRGScaledMetric<Value>: DynamicProperty where Value : BinaryFloatingPoint {
    let style: SRGFont.Style
    
    @ScaledMetric var unboundValue: Value
    
    /// Creates the scaled metric with an unscaled value and a text style to scale relative to.
    public init(wrappedValue: Value, relativeTo style: SRGFont.Style = .body) {
        self.style = style
        let textStyle = Self.textStyle(from: SRGFont.textStyle(for: style))
        self._unboundValue = ScaledMetric(wrappedValue: wrappedValue, relativeTo: textStyle)
    }
    
    public var wrappedValue: Value {
        return Value.minimum(unboundValue, Value(SRGFont.maximumSize(for: style)))
    }
    
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
}
