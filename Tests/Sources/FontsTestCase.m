//
//  Copyright (c) SRG SSR. All rights reserved.
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

- (void)testMultipleFontRegistration
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"Sketch" ofType:@"ttf"];
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

- (void)testRegularFont
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
    
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testBoldFont
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
    
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testHeavyFont
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
    
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_heavyFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testLightFont
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
    
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_lightFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testMediumFont
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
    
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_mediumFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testItalicFont
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
    
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_italicFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testBoldItalicFont
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
    
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_boldItalicFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testRegularSerifFont
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
    
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_regularSerifFontWithTextStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testCustomFont
{
    NSString *fontFilePath = [[NSBundle mainBundle] pathForResource:@"Venetian" ofType:@"otf"];
    XCTAssertTrue(SRGAppearanceRegisterFont(fontFilePath));
    
    static NSString *kFontName = @"Venetian";
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle1]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle2]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle3]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleSubheadline]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCallout]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleFootnote]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCaption1]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCaption2]);
    
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleCaption]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleSubtitle]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleBody]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleHeadline]);
    XCTAssertNotNil([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleTitle]);
}

- (void)testMissingFont
{
    static NSString *kFontName = @"Missing";
    static NSString *kFallbackFontName = @"Helvetica";
    
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle1].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle2].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleTitle3].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleHeadline].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleSubheadline].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleBody].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCallout].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleFootnote].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCaption1].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:UIFontTextStyleCaption2].fontName, kFallbackFontName);
    
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleCaption].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleSubtitle].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleBody].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleHeadline].fontName, kFallbackFontName);
    XCTAssertEqualObjects([UIFont srg_fontWithName:kFontName textStyle:SRGAppearanceFontTextStyleTitle].fontName, kFallbackFontName);
}

@end
