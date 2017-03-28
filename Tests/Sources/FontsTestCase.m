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

@end
