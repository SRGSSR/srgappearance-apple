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

- (void)testFontsWithStyle
{
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyText style:SRGFontStyleH1].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyDisplay style:SRGFontStyleH1].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testFontsWithWeightSizeRelativeToTextStyle
{
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyText weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyDisplay weight:UIFontWeightRegular size:10 relativeToTextStyle:UIFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

- (void)testFontsWithWeightAndFixedSize
{
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyText weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeTextVFApp-Medium"]);
    XCTAssertTrue([[SRGFont fontWithFamily:SRGFontFamilyDisplay weight:UIFontWeightRegular fixedSize:10].fontName isEqualToString:@"SRGSSRTypeDisplayVFApp-Medium"]);
}

@end
