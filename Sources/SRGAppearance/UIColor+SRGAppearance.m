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
    return [UIColor srg_colorFromHexadecimalString:@"#af001e"];
}

+ (UIColor *)srg_lightRedColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#d50000"];
}

+ (UIColor *)srg_darkRedColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#8b0019"];
}

+ (UIColor *)srg_blueColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#0f5acb"];
}

+ (UIColor *)srg_gray16Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#161616"];
}

+ (UIColor *)srg_gray23Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#232323"];
}

+ (UIColor *)srg_gray33Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#333333"];
}

+ (UIColor *)srg_gray4AColor
{
    return [UIColor srg_colorFromHexadecimalString:@"#4a4a4a"];
}

+ (UIColor *)srg_gray71Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#717171"];
}

+ (UIColor *)srg_gray96Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#969696"];
}

+ (UIColor *)srg_grayC7Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#c7c7c7"];
}

+ (UIColor *)srg_grayD2Color
{
    return [UIColor srg_colorFromHexadecimalString:@"#d2d2d2"];
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
    
    NSString *string = [value hasPrefix:@"#"] ? [value substringFromIndex:1] : value;
    if (string.length != 6 && string.length != 8) {
        return nil;
    }
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    if (! [scanner scanHexInt:&rgbValue]) {
        return nil;
    }
    
    if (string.length == 8) {
        CGFloat red = ((rgbValue & 0xFF000000) >> 24) / 255.f;
        CGFloat green = ((rgbValue & 0x00FF0000) >> 16) / 255.f;
        CGFloat blue = ((rgbValue & 0x0000FF00) >> 8) / 255.f;
        CGFloat alpha = (rgbValue & 0x000000FF) / 255.f;
        return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    }
    else {
        CGFloat red = ((rgbValue & 0xFF0000) >> 16) / 255.f;
        CGFloat green = ((rgbValue & 0x00FF00) >> 8) / 255.f;
        CGFloat blue = (rgbValue & 0x0000FF) / 255.f;
        return [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
    }
}

- (id)reverseTransformedValue:(id)value
{
    if (! [value isKindOfClass:UIColor.class]) {
        return nil;
    }
    
    const CGFloat *components = CGColorGetComponents([value CGColor]);
    
    long red = lroundf(components[0] * 255);
    long green = lroundf(components[1] * 255);
    long blue = lroundf(components[2] * 255);
    long alpha = lroundf(components[3] * 255);
    
    if (alpha == 255) {
        return [NSString stringWithFormat:@"#%02lx%02lx%02lx", red, green, blue];
    }
    else {
        return [NSString stringWithFormat:@"#%02lx%02lx%02lx%02lx", red, green, blue, alpha];
    }
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
