//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "SRGVariationAxis.h"

@import CoreText;
@import UIKit;

static NSMutableDictionary<NSString *, NSArray<SRGVariationAxis *> *> *s_variationAxes;

@interface SRGVariationAxis ()

@property (nonatomic) NSNumber *identifier;
@property (nonatomic, copy) NSString *name;

@property (nonatomic) CGFloat minimumValue;
@property (nonatomic) CGFloat maximumValue;

@property (nonatomic) CGFloat defaultValue;

@end

@implementation SRGVariationAxis

#pragma mark Class methods

+ (NSArray<SRGVariationAxis *> *)variationAxesForFontWithName:(NSString *)fontName
{
    if (! s_variationAxes) {
        s_variationAxes = [NSMutableDictionary dictionary];
    }
    
    NSArray<SRGVariationAxis *> *variationAxes = s_variationAxes[fontName];
    if (variationAxes) {
        return variationAxes;
    }
    else {
        UIFont *font = [UIFont fontWithName:fontName size:10.f /* arbitrary */];
        if (! font) {
            return nil;
        }
        
        variationAxes = [self variationAxesForFont:font];
        s_variationAxes[fontName] = variationAxes;
        return variationAxes;
    }
}

+ (NSArray<SRGVariationAxis *> *)variationAxesForFont:(UIFont *)font
{
    NSMutableArray<SRGVariationAxis *> *variationAxes = [NSMutableArray array];
    
    NSArray<NSDictionary<NSString *, id> *> *axisDictionaries = CFBridgingRelease(CTFontCopyVariationAxes((__bridge CTFontRef)font));
    for (NSDictionary<NSString *, id> *axisDictionary in axisDictionaries) {
        SRGVariationAxis *variationAxis = [[SRGVariationAxis alloc] initWithDictionary:axisDictionary];
        if (variationAxis) {
            [variationAxes addObject:variationAxis];
        }
    }
    
    return variationAxes.copy;
}

#pragma mark Object lifecycle

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dictionary
{
    if (self = [super init]) {
        // According to `CTFontCopyVariationAxes` documentation, font dictionaries should be complete and contain all values,
        // but it does not hurt to be a bit more careful.
        self.identifier = dictionary[(__bridge NSString *)kCTFontVariationAxisIdentifierKey];
        if (! self.identifier) {
            return nil;
        }
        
        self.name = dictionary[(__bridge NSString *)kCTFontVariationAxisNameKey];
        if (! self.name) {
            return nil;
        }
        
        NSNumber *minimumValueNumber = dictionary[(__bridge NSString *)kCTFontVariationAxisMinimumValueKey];
        if (! minimumValueNumber) {
            return nil;
        }
        self.minimumValue = minimumValueNumber.floatValue;
        
        NSNumber *maximumValueNumber = dictionary[(__bridge NSString *)kCTFontVariationAxisMaximumValueKey];
        if (! maximumValueNumber) {
            return nil;
        }
        self.maximumValue = maximumValueNumber.floatValue;
        
        NSNumber *defaultValueNumber = dictionary[(__bridge NSString *)kCTFontVariationAxisDefaultValueKey];
        if (! defaultValueNumber) {
            return nil;
        }
        self.defaultValue = defaultValueNumber.floatValue;
    }
    return self;
}

#pragma mark Getters and setters

- (id)attribute
{
    if (@available(iOS 14, *)) {
        return self.identifier;
    }
    else {
        return self.name;
    }
}

#pragma mark Description

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p; identifier = %@; name = %@; minimumValue = %@; defaultValue = %@; "
            "maximumValue = %@>",
            self.class,
            self,
            self.identifier,
            self.name,
            @(self.minimumValue),
            @(self.defaultValue),
            @(self.maximumValue)];
}

@end
