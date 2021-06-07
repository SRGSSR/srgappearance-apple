//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
public extension Color {
    /**
     *  Standard colors.
     */
    static let srg_red = Color(UIColor.srg_red)
    static let srg_lightRed = Color(UIColor.srg_lightRed)
    static let srg_darkRed = Color(UIColor.srg_darkRed)
    static let srg_blue = Color(UIColor.srg_blue)
    
    /**
     *  Standard grays.
     */
    static let srg_gray1 = Color(UIColor.srg_gray1)
    static let srg_gray2 = Color(UIColor.srg_gray2)
    static let srg_gray3 = Color(UIColor.srg_gray3)
    static let srg_gray4 = Color(UIColor.srg_gray4)
    static let srg_gray5 = Color(UIColor.srg_gray5)
    
    /**
     *  Return the color matching a hexadecimal #rrggbbaa or #rrggbb string representation (the leading wildcard is optional),
     *  or the clear color if the string does not correspond to a color. Supports uppercase or lowercase digits.
     */
    static func srg_hexadecimal(_ string: String) -> Color {
        return Color(.srg_color(fromHexadecimalString: string) ?? .clear)
    }
}
