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

- (void)testFontNamesWithTextStyle
{
    XCTAssertTrue([[UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Regular"]);
    XCTAssertTrue([[UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Bold"]);
    XCTAssertTrue([[UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Heavy"]);
    XCTAssertTrue([[UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Light"]);
    XCTAssertTrue([[UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Medium"]);
    XCTAssertTrue([[UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-Italic"]);
    XCTAssertTrue([[UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeTextApp-BoldItalic"]);
    
    XCTAssertTrue([[UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Regular"]);
    XCTAssertTrue([[UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Light"]);
    XCTAssertTrue([[UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Medium"]);
}

- (void)testFontNamesWithSize
{
    XCTAssertTrue([[UIFont srg_regularFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Regular"]);
    XCTAssertTrue([[UIFont srg_boldFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Bold"]);
    XCTAssertTrue([[UIFont srg_heavyFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Heavy"]);
    XCTAssertTrue([[UIFont srg_lightFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Light"]);
    XCTAssertTrue([[UIFont srg_mediumFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Medium"]);
    XCTAssertTrue([[UIFont srg_italicFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-Italic"]);
    XCTAssertTrue([[UIFont srg_boldItalicFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeTextApp-BoldItalic"]);
    
    XCTAssertTrue([[UIFont srg_regularSerifFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Regular"]);
    XCTAssertTrue([[UIFont srg_lightSerifFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Light"]);
    XCTAssertTrue([[UIFont srg_mediumSerifFontWithSize:15.f].fontName isEqualToString:@"SRGSSRTypeSerifTextApp-Medium"]);
}

- (void)testRegularFont
{
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testBoldFont
{
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testHeavyFont
{
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testLightFont
{
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testMediumFont
{
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testItalicFont
{
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testBoldItalicFont
{
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testRegularSerifFont
{
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testLightSerifFont
{
    XCTAssertNotNil([UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_lightSerifFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testMediumSerifFont
{
    XCTAssertNotNil([UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_mediumSerifFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

@end
