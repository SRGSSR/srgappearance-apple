//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import <SRGAppearance/SRGAppearance.h>
#import <XCTest/XCTest.h>

NSString *TestImagePath(void)
{
    return [[NSBundle mainBundle] pathForResource:@"TestImage" ofType:@"pdf"];
}

@interface ImageTestCase : XCTestCase

@end

@implementation ImageTestCase

#pragma mark Setup and teardown

- (void)setUp
{
    [UIImage srg_clearVectorImageCache];
}

#pragma mark Tests

- (void)testValidVectorImage
{
    CGSize size = CGSizeMake(100.f, 200.f);
    UIImage *image = [UIImage srg_vectorImageAtPath:TestImagePath() withSize:size];
    XCTAssertNotNil(image);
    XCTAssertTrue(CGSizeEqualToSize(image.size, size));
}

- (void)testInvalidVectorImage
{
    XCTAssertNil([UIImage srg_vectorImageAtPath:@"/invalid/path" withSize:CGSizeMake(100.f, 150.f)]);
}

- (void)testTintedImageWithColor
{
    UIImage *image = [UIImage imageWithContentsOfFile:TestImagePath()];
    XCTAssertEqualObjects([image srg_imageTintedWithColor:nil], image);
    
    UIImage *tintedImage = [image srg_imageTintedWithColor:[UIColor blueColor]];
    XCTAssertTrue(CGSizeEqualToSize(image.size, tintedImage.size));
}

@end
