//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <SRGAppearance/SRGAppearance.h>
#import <XCTest/XCTest.h>

@interface ColorTestCase : XCTestCase

@end

@implementation ColorTestCase

- (void)testColorFromHexadecimalString
{
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#ff0000"], UIColor.redColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#00ff00"], UIColor.greenColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#0000ff"], UIColor.blueColor);
    
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"FF0000"], UIColor.redColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"ff0000"], UIColor.redColor);
    
    XCTAssertNil([UIColor srg_colorFromHexadecimalString:@"#zzzzzz"]);
}

- (void)testHexadecimalString
{
    XCTAssertEqualObjects(UIColor.redColor.srg_hexadecimalString, @"#ff0000");
    XCTAssertEqualObjects(UIColor.greenColor.srg_hexadecimalString, @"#00ff00");
    XCTAssertEqualObjects(UIColor.blueColor.srg_hexadecimalString, @"#0000ff");
}

- (void)testHexadecimalColorTransformer
{
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#ff0000"], UIColor.redColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#00ff00"], UIColor.greenColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#0000ff"], UIColor.blueColor);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"ff0000"], UIColor.redColor);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.redColor], @"#ff0000");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.greenColor], @"#00ff00");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.blueColor], @"#0000ff");
}

@end
