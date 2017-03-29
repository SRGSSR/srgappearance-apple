//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "FontsViewController.h"

#import <SRGAppearance/SRGAppearance.h>

@interface FontsViewController ()

@property (nonatomic) NSArray<NSAttributedString *> *titles;

@end

@implementation FontsViewController

#pragma mark Object lifecycle

- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([self class]) bundle:nil];
    return [storyboard instantiateInitialViewController];
}

#pragma mark Getters and setters

- (NSString *)title
{
    return NSLocalizedString(@"Fonts", nil);
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    static NSDictionary<NSString *, NSString *> *s_textStyleNames;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_textStyleNames = @{ UIFontTextStyleTitle1 : @"Title1",
                              UIFontTextStyleTitle2 : @"Title2",
                              UIFontTextStyleTitle3 : @"Title3",
                              UIFontTextStyleHeadline : @"Headline",
                              UIFontTextStyleSubheadline : @"Subheadline",
                              UIFontTextStyleBody : @"Body",
                              UIFontTextStyleCallout : @"Callout",
                              UIFontTextStyleFootnote : @"Footnote",
                              UIFontTextStyleCaption1 : @"Caption1",
                              UIFontTextStyleCaption2 : @"Caption2" };
    });
    
    NSMutableArray<NSAttributedString *> *titles = [NSMutableArray array];
    NSArray<NSString *> *textStyles = [s_textStyleNames.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *textStyle in textStyles) {
        UIFont *font = [UIFont srg_regularFontWithTextStyle:textStyle];
        NSString *titleString = [NSString stringWithFormat:@"%@ (%@)", s_textStyleNames[textStyle], @(font.pointSize)];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleString attributes:@{ NSFontAttributeName : font }];
        [titles addObject:title];
    }
    self.titles = [titles copy];
}

#pragma mark UITableViewDataSource protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
}

#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.attributedText = self.titles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

@end
