//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "UIColor+SRGAppearance.h"

@interface SRGHexadecimalColorValueTransformer : NSValueTransformer

@end

@implementation UIColor (SRGAppearance)

#pragma mark Class methods

+ (UIColor *)srg_redColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#9d0018"];
}

+ (UIColor *)srg_blueColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#0f5acb"];
}

+ (UIColor *)srg_colorFromHexadecimalString:(NSString *)hexadecimalString
{
    return [SRGHexadecimalColorTransformer() transformedValue:hexadecimalString];
}

#pragma mark Getters and setters

- (NSString *)srg_hexadecimalString
{
    return [SRGHexadecimalColorTransformer() reverseTransformedValue:self];
}

@end

@implementation SRGHexadecimalColorValueTransformer

#pragma mark Overrides

+ (Class)transformedValueClass
{
    return UIColor.class;
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    if (! [value isKindOfClass:NSString.class]) {
        return nil;
    }
    
    NSScanner *scanner = [NSScanner scannerWithString:value];
    if ([value hasPrefix:@"#"]) {
        scanner.scanLocation = 1;
    }
    
    unsigned rgbValue = 0;
    if (! [scanner scanHexInt:&rgbValue]) {
        return nil;
    }
    
    CGFloat red = ((rgbValue & 0xFF0000) >> 16) / 255.f;
    CGFloat green = ((rgbValue & 0x00FF00) >> 8) / 255.f;
    CGFloat blue = (rgbValue & 0x0000FF) / 255.f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
}

- (id)reverseTransformedValue:(id)value
{
    if (! [value isKindOfClass:UIColor.class]) {
        return nil;
    }
    
    const CGFloat *components = CGColorGetComponents([value CGColor]);
    return [NSString stringWithFormat:@"#%02lx%02lx%02lx", lroundf(components[0] * 255), lroundf(components[1] * 255), lroundf(components[2] * 255)];
}

@end

NSValueTransformer *SRGHexadecimalColorTransformer(void)
{
    static NSValueTransformer *s_transformer;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_transformer = [[SRGHexadecimalColorValueTransformer alloc] init];
    });
    return s_transformer;
}
