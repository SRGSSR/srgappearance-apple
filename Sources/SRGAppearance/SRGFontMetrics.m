//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGFontMetrics.h"

@interface SRGFontMetrics ()

@property (nonatomic) SRGFontStyle style;

@end

@implementation SRGFontMetrics

#pragma mark Class methods

+ (SRGFontMetrics *)metricsForFontStyle:(SRGFontStyle *)style
{
    return [[self alloc] initForFontStyle:style];
}

#pragma mark Object lifecycle

- (instancetype)initForFontStyle:(SRGFontStyle)style
{
    if ([super initForTextStyle:[SRGFont textStyleForFontStyle:style]]) {
        self.style = style;
    }
    return self;
}

#pragma mark Getters and setters

- (CGFloat)maximumValue
{
    return [SRGFont maximumSizeForFontStyle:self.style];
}

#pragma mark Helpers

- (UIFont *)majorizedScaledFontForFont:(UIFont *)font
{
    CGFloat maximumValue = [self maximumValue];
    if (font.pointSize > maximumValue) {
        font = [font fontWithSize:maximumValue];
    }
    return font;
}

- (CGFloat)majorizedValue:(CGFloat)value
{
    return fmin(value, [self maximumValue]);
}

#pragma mark Overrides

- (UIFont *)scaledFontForFont:(UIFont *)font
{
    UIFont *scaledFont = [super scaledFontForFont:font];
    return [self majorizedScaledFontForFont:scaledFont];
}

- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximumPointSize
{
    UIFont *scaledFont = [super scaledFontForFont:font maximumPointSize:maximumPointSize];
    return [self majorizedScaledFontForFont:scaledFont];
}

- (UIFont *)scaledFontForFont:(UIFont *)font compatibleWithTraitCollection:(UITraitCollection *)traitCollection
{
    UIFont *scaledFont = [super scaledFontForFont:font compatibleWithTraitCollection:traitCollection];
    return [self majorizedScaledFontForFont:scaledFont];
}

- (UIFont *)scaledFontForFont:(UIFont *)font maximumPointSize:(CGFloat)maximumPointSize compatibleWithTraitCollection:(UITraitCollection *)traitCollection
{
    UIFont *scaledFont = [super scaledFontForFont:font maximumPointSize:maximumPointSize compatibleWithTraitCollection:traitCollection];
    return [self majorizedScaledFontForFont:scaledFont];
}

- (CGFloat)scaledValueForValue:(CGFloat)value
{
    CGFloat scaledValue = [super scaledValueForValue:value];
    return [self majorizedValue:scaledValue];
}

- (CGFloat)scaledValueForValue:(CGFloat)value compatibleWithTraitCollection:(UITraitCollection *)traitCollection
{
    CGFloat scaledValue = [super scaledValueForValue:value compatibleWithTraitCollection:traitCollection];
    return [self majorizedValue:scaledValue];
}

@end
