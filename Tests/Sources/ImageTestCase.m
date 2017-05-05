//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <SRGAppearance/SRGAppearance.h>
#import <XCTest/XCTest.h>

@interface ImageTestCase : XCTestCase

@end

@implementation ImageTestCase

#pragma mark Setup and teardown

- (void)setUp
{
    [UIImage srg_clearVectorImageCache];
}

#pragma mark Tests

- (void)testStandardImages
{
    XCTAssertNotNil(SRGAppearanceMediaPlaceholder());
}

- (void)testValidVectorImage
{
    CGSize size = CGSizeMake(100.f, 200.f);
    UIImage *image = [UIImage srg_vectorImageAtPath:SRGAppearanceMediaPlaceholder() withSize:size];
    XCTAssertNotNil(image);
    XCTAssertTrue(CGSizeEqualToSize(image.size, size));
}

- (void)testInvalidVectorImage
{
    XCTAssertNil([UIImage srg_vectorImageAtPath:@"/invalid/path" withSize:CGSizeMake(100.f, 150.f)]);
}

@end
