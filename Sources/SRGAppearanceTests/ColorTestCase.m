//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

@import SRGAppearance;
@import XCTest;

@interface ColorTestCase : XCTestCase

@end

@implementation ColorTestCase

- (void)testColorFromHexadecimalString
{
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#ff0000"], UIColor.redColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#00ff00"], UIColor.greenColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#0000ff"], UIColor.blueColor);
    
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#ff000080"], [UIColor.redColor colorWithAlphaComponent:128.f / 255.f]);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#ff000000"], [UIColor.redColor colorWithAlphaComponent:0.f]);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"#ff0000ff"], [UIColor.redColor colorWithAlphaComponent:1.f]);
    
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"FF0000"], UIColor.redColor);
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"ff0000"], UIColor.redColor);
    
    XCTAssertNil([UIColor srg_colorFromHexadecimalString:@"#zzzzzz"]);
}

- (void)testHexadecimalString
{
    XCTAssertEqualObjects(UIColor.redColor.srg_hexadecimalString, @"#ff0000");
    XCTAssertEqualObjects(UIColor.greenColor.srg_hexadecimalString, @"#00ff00");
    XCTAssertEqualObjects(UIColor.blueColor.srg_hexadecimalString, @"#0000ff");
    
    XCTAssertEqualObjects([UIColor.redColor colorWithAlphaComponent:128.f / 255.f].srg_hexadecimalString, @"#ff000080");
    XCTAssertEqualObjects([UIColor.redColor colorWithAlphaComponent:0.5f].srg_hexadecimalString, @"#ff000080");
    
    XCTAssertEqualObjects([UIColor srg_colorFromHexadecimalString:@"FF0000FF"].srg_hexadecimalString, @"#ff0000");
}

- (void)testHexadecimalColorTransformer
{
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#ff0000"], UIColor.redColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#00ff00"], UIColor.greenColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#0000ff"], UIColor.blueColor);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#ff0000ff"], UIColor.redColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#00ff00ff"], UIColor.greenColor);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#0000ffff"], UIColor.blueColor);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#ff000080"], [UIColor.redColor colorWithAlphaComponent:128.f / 255.f]);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#00ff0080"], [UIColor.greenColor colorWithAlphaComponent:128.f / 255.f]);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#0000ff80"], [UIColor.blueColor colorWithAlphaComponent:128.f / 255.f]);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#ff000000"], [UIColor.redColor colorWithAlphaComponent:0.f]);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#00ff0000"], [UIColor.greenColor colorWithAlphaComponent:0.f]);
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"#0000ff00"], [UIColor.blueColor colorWithAlphaComponent:0.f]);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() transformedValue:@"ff0000"], UIColor.redColor);
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.redColor], @"#ff0000");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.greenColor], @"#00ff00");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:UIColor.blueColor], @"#0000ff");
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.redColor colorWithAlphaComponent:128.f / 255.f]], @"#ff000080");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.greenColor colorWithAlphaComponent:128.f / 255.f]], @"#00ff0080");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.blueColor colorWithAlphaComponent:128.f / 255.f]], @"#0000ff80");
    
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.redColor colorWithAlphaComponent:0.f]], @"#ff000000");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.greenColor colorWithAlphaComponent:0.f]], @"#00ff0000");
    XCTAssertEqualObjects([SRGHexadecimalColorTransformer() reverseTransformedValue:[UIColor.blueColor colorWithAlphaComponent:0.f]], @"#0000ff00");
}

@end
