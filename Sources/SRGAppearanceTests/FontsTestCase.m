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

- (void)testValidFontRegistration
{
    NSString *fontFilePath = [SWIFTPM_MODULE_BUNDLE pathForResource:@"FontAwesome" ofType:@"otf"];
    XCTAssertFalse([[UIFont familyNames] containsObject:@"FontAwesome"]);
    XCTAssertTrue(SRGAppearanceRegisterFont(fontFilePath));
    XCTAssertTrue([[UIFont familyNames] containsObject:@"FontAwesome"]);
}

- (void)testCorruptFontRegistration
{
    NSString *fontFilePath = [SWIFTPM_MODULE_BUNDLE pathForResource:@"Corrupt" ofType:@"otf"];
    XCTAssertFalse(SRGAppearanceRegisterFont(fontFilePath));
}

- (void)testMissingFontRegistration
{
    NSString *fontFilePath = [SWIFTPM_MODULE_BUNDLE pathForResource:@"Missing" ofType:@"otf"];
    XCTAssertFalse(SRGAppearanceRegisterFont(fontFilePath));
}

- (void)testMultipleFontRegistration
{
    NSString *fontFilePath = [SWIFTPM_MODULE_BUNDLE pathForResource:@"Sketch" ofType:@"ttf"];
    XCTAssertTrue(SRGAppearanceRegisterFont(fontFilePath));
    XCTAssertFalse(SRGAppearanceRegisterFont(fontFilePath));
}

- (void)testContentSizeCategoriesComparison
{
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategoryExtraSmall), NSOrderedSame);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall), NSOrderedAscending);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategorySmall, UIContentSizeCategoryExtraSmall), NSOrderedDescending);
    XCTAssertThrows(SRGAppearanceCompareContentSizeCategories(@"unknown", UIContentSizeCategorySmall));
}

- (void)testTextFontWithStyleAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleTitle1].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleTitle2].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleHeadline1].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleHeadline2].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleSubtitle].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleButton1].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleButton2].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleOverline].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleLabel].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText style:SRGFontStyleCaption].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithStyleAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleTitle1].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleTitle2].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleHeadline1].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleHeadline2].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleSubtitle].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleButton1].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleButton2].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleOverline].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleLabel].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay style:SRGFontStyleCaption].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testTextFontWithWeightSizeAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText weight:UIFontWeightRegular size:10 relativeTo:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithWeightSizeAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay weight:UIFontWeightRegular size:10 relativeTo:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testTextFontWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeText weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithType:SRGFontTypeDisplay weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

@end
