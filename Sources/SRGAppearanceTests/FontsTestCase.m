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
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleTitle1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleTitle2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleHeadline1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleHeadline2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleSubtitle relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleBody relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleButton1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleButton2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleOverline relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleLabel relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText style:SRGFontStyleCaption relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithStyleAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleTitle1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleTitle2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleHeadline1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleHeadline2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleSubtitle relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleBody relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleButton1 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleButton2 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleOverline relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleLabel relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay style:SRGFontStyleCaption relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testTextFontWithWeightSizeAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithWeightSizeAndTextStyle
{
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testTextFontWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameText weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
}

- (void)testDisplayFontWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithName:SRGFontNameDisplay weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

@end
