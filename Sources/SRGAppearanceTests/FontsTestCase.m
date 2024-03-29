//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import SRGAppearance;
@import XCTest;

@interface FontsTestCase : XCTestCase

@end

@implementation FontsTestCase

- (void)testContentSizeCategoriesComparison
{
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategoryExtraSmall), NSOrderedSame);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall), NSOrderedAscending);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategorySmall, UIContentSizeCategoryExtraSmall), NSOrderedDescending);
    XCTAssertThrows(SRGAppearanceCompareContentSizeCategories(@"unknown", UIContentSizeCategorySmall));
}

- (void)testFontsWithStyle
{
    XCTAssertTrue([[SRGFont fontWithStyle:SRGFontStyleH1].fontName containsString:@"SRGSSRType"]);
    XCTAssertTrue([[SRGFont fontWithStyle:SRGFontStyleH1].fontName containsString:@"SRGSSRType"]);
}

- (void)testFontsWithWeightSizeRelativeToTextStyle
{
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyText weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName containsString:@"SRGSSRType"]);
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyDisplay weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName containsString:@"SRGSSRType"]);
}

- (void)testFontsWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyText weight:UIFontWeightRegular fixedSize:10].fontName containsString:@"SRGSSRType"]);
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyDisplay weight:UIFontWeightRegular fixedSize:10].fontName containsString:@"SRGSSRType"]);
}

- (void)testSizeForFontStyle
{
    XCTAssertEqual([SRGFont sizeForFontStyle:SRGFontStyleBody maximumSize:4.], 4.);
    XCTAssertTrue([SRGFont sizeForFontStyle:SRGFontStyleBody] > 4.);
}

- (void)testUIFontPerformance
{
    [self measureBlock:^{
        for (NSInteger i = 0; i < 10000; ++i) {
            __unused UIFont *font = [UIFont fontWithName:@"SRGSSRTypeTextVFApp-Medium" size:16.f];
        }
    }];
}

- (void)testSRGFontPerformance
{
    [self measureBlock:^{
        for (NSInteger i = 0; i < 10000; ++i) {
            __unused UIFont *font = [SRGFont fontWithStyle:SRGFontStyleBody];
        }
    }];
}

@end
