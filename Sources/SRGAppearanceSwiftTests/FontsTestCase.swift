//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearanceSwift
import XCTest

class FontsTestCase: XCTestCase {
    func testFontsWithStyle() {
        XCTAssertTrue(SRGFont.font(.body).fontName == "SRGSSRTypeTextVFApp-Medium")
    }
    
    func testFontsWithWeightSizeRelativeToTextStyle() {
        XCTAssertTrue(SRGFont.font(family: .text, weight: .ultraLight, size: 10, relativeTo: .body).fontName.contains("SRGSSRType"))
    }
    
    func testFontsWithWeightAndFixedSize() {
        XCTAssertTrue(SRGFont.font(family: .text, weight: .ultraLight, fixedSize: 10).fontName.contains("SRGSSRType"))
    }
}
