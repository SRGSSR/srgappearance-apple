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
    static let srgGray1 = __srg_gray1
    static let srgGray2 = __srg_gray2
    static let srgGray3 = __srg_gray3
    static let srgGray4 = __srg_gray4
    static let srgGray5 = __srg_gray5
    
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
    static let srgGray1 = Color(UIColor.srgGray1)
    static let srgGray2 = Color(UIColor.srgGray2)
    static let srgGray3 = Color(UIColor.srgGray3)
    static let srgGray4 = Color(UIColor.srgGray4)
    static let srgGray5 = Color(UIColor.srgGray5)
    
    /**
     *  Returns the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
     *  or the clear color if the string does not correspond to a color. Supports uppercase or lowercase digits.
     */
    static func hexadecimal(_ string: String) -> Color {
        return Color(.hexadecimal(string) ?? .clear)
    }
}
