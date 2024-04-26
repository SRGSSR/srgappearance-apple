//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SwiftUI
import UIKit

public extension UIColor {
    /**
     *  Standard colors.
     */
    static let srgRed = __srg_red
    static let srgLightRed = __srg_lightRed
    static let srgDarkRed = __srg_darkRed
    static let srgBlue = __srg_blue
    
    /**
     *  Standard grays.
     */
    static let srgGray16 = __srg_gray16
    static let srgGray23 = __srg_gray23
    static let srgGray33 = __srg_gray33
    static let srgGray4A = __srg_gray4A
    static let srgGray71 = __srg_gray71
    static let srgGray96 = __srg_gray96
    @available(*, deprecated, message: "Use srgGrayD2 instead")
    static let srgGrayC7 = __srg_grayC7
    static let srgGrayD2 = __srg_grayD2
    
    /**
     *  Returns the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
     *  or `nil` if the string does not correspond to a color. Supports uppercase or lowercase digits.
     */
    static func hexadecimal(_ string: String) -> UIColor? {
        return __srg_color(fromHexadecimalString: string)
    }
    
    func hexadecimal() -> String {
        return __srg_hexadecimalString
    }
}

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension Color {
    /**
     *  Standard colors.
     */
    static let srgRed = Color(UIColor.srgRed)
    static let srgLightRed = Color(UIColor.srgLightRed)
    static let srgDarkRed = Color(UIColor.srgDarkRed)
    static let srgBlue = Color(UIColor.srgBlue)
    
    /**
     *  Standard grays.
     */
    static let srgGray16 = Color(UIColor.srgGray16)
    static let srgGray23 = Color(UIColor.srgGray23)
    static let srgGray33 = Color(UIColor.srgGray33)
    static let srgGray4A = Color(UIColor.srgGray4A)
    static let srgGray71 = Color(UIColor.srgGray71)
    static let srgGray96 = Color(UIColor.srgGray96)
    @available(*, deprecated, message: "Use srgGrayD2 instead")
    static let srgGrayC7 = Color(UIColor.srgGrayC7)
    static let srgGrayD2 = Color(UIColor.srgGrayD2)
    
    /**
     *  Returns the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
     *  or the clear color if the string does not correspond to a color. Supports uppercase or lowercase digits.
     */
    static func hexadecimal(_ string: String) -> Color {
        return Color(.hexadecimal(string) ?? .clear)
    }
}
