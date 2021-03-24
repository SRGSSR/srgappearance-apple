//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

import SRGAppearanceSwift
import XCTest

class FontsTestCase: XCTestCase {
    func testFontsWithStyle() {
        XCTAssertTrue(SRGFont.font(.text, style: .body).fontName == "SRGSSRTypeTextVFApp-Medium")
        XCTAssertTrue(SRGFont.font(.display, style: .body).fontName == "SRGSSRTypeDisplayVFApp-Medium")
    }
    
    func testFontsWithWeightSizeRelativeToTextStyle() {
        XCTAssertTrue(SRGFont.font(.text, weight: .ultraLight, size: 10, relativeTo: .body).fontName == "SRGSSRTypeTextVFApp-Medium")
        XCTAssertTrue(SRGFont.font(.text, weight: .srg_light, size: 10, relativeTo: .body).fontName == "SRGSSRTypeTextVFApp-Medium")
    }
    
    func testFontsWithWeightAndFixedSize() {
        XCTAssertTrue(SRGFont.font(.text, weight: .ultraLight, fixedSize: 10).fontName == "SRGSSRTypeTextVFApp-Medium")
        XCTAssertTrue(SRGFont.font(.text, weight: .srg_light, fixedSize: 10).fontName == "SRGSSRTypeTextVFApp-Medium")
    }
}
