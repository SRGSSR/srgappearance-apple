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
    let value: Value
    let style: SRGFont.Style
    
    @Environment(\.sizeCategory) private var sizeCategory
    
    /// Creates the scaled metric with an unscaled value and a text style to scale relative to.
    public init(wrappedValue: Value, relativeTo style: SRGFont.Style = .body) {
        self.value = wrappedValue
        self.style = style
    }
    
    public var wrappedValue: Value {
        return Value(SRGFont.metricsForFont(with: style).scaledValue(for: CGFloat(value)))
    }
}
