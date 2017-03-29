//
//  Copyright (c) SRG. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <SRGAppearance/SRGAppearance.h>
#import <XCTest/XCTest.h>

@interface FontsTestCase : XCTestCase

@end

@implementation FontsTestCase

- (void)testValidFontRegistration
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"FontAwesome" ofType:@"otf"];
    XCTAssertFalse([[UIFont familyNames] containsObject:@"FontAwesome"]);
    XCTAssertTrue(SRGAppearanceRegisterFont(fontFilePath));
    XCTAssertTrue([[UIFont familyNames] containsObject:@"FontAwesome"]);
}

- (void)testCorruptFontRegistration
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"Corrupt" ofType:@"otf"];
    XCTAssertFalse(SRGAppearanceRegisterFont(fontFilePath));
}

- (void)testMissingFontRegistration
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"Missing" ofType:@"otf"];
    XCTAssertFalse(SRGAppearanceRegisterFont(fontFilePath));
}

- (void)testContentSizeCategoriesComparison
{
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategoryExtraSmall), NSOrderedSame);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategoryExtraSmall, UIContentSizeCategorySmall), NSOrderedAscending);
    XCTAssertEqual(SRGAppearanceCompareContentSizeCategories(UIContentSizeCategorySmall, UIContentSizeCategoryExtraSmall), NSOrderedDescending);
    XCTAssertThrows(SRGAppearanceCompareContentSizeCategories(@"unknown", UIContentSizeCategorySmall));
}

- (void)testRegularFonts
{
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testBoldFonts
{
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testHeavyFonts
{
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testLightFonts
{
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testMediumFonts
{
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testItalicFonts
{
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testBoldItalicFonts
{
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:UIFontTextStyleCaption2]);
}

- (void)testRegularSerifFonts
{
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:UIFontTextStyleCaption2]);
}

@end
