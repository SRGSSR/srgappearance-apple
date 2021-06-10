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

#pragma mark Helpers

- (UIFont *)majorizedScaledFontForFont:(UIFont *)font
{
    CGFloat maximumValue = [SRGFont maximumSizeForFontStyle:self.style];
    if (font.pointSize > maximumValue) {
        font = [font fontWithSize:maximumValue];
    }
    return font;
}

- (CGFloat)majorizedScaledValue:(CGFloat)scaledValue forValue:(CGFloat)value
{
    return fmin(scaledValue, value * [SRGFont maximumSizeForFontStyle:self.style] / [SRGFont sizeForFontStyle:self.style]);
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
    return [self majorizedScaledValue:scaledValue forValue:value];
}

- (CGFloat)scaledValueForValue:(CGFloat)value compatibleWithTraitCollection:(UITraitCollection *)traitCollection
{
    CGFloat scaledValue = [super scaledValueForValue:value compatibleWithTraitCollection:traitCollection];
    return [self majorizedScaledValue:scaledValue forValue:value];
}

@end
