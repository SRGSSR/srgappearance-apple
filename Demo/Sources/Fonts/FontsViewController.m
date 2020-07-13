//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "FontsViewController.h"

#import "Resources.h"

#import <SRGAppearance/SRGAppearance.h>

@interface FontsViewController ()

@property (nonatomic) NSArray<NSAttributedString *> *customTitles;
@property (nonatomic) NSArray<NSAttributedString *> *standardTitles;

@end

@implementation FontsViewController

#pragma mark Class methods

+ (NSArray<NSAttributedString *> *)titlesForStandardTextStyles
{
    static NSDictionary<NSString *, NSString *> *s_standardTextStyleNames;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_standardTextStyleNames = @{ UIFontTextStyleTitle1 : @"Title1",
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
    return [self titlesForTextStyles:s_standardTextStyleNames];
}

+ (NSArray<NSAttributedString *> *)titlesForCustomTextStyles
{
    static NSDictionary<NSString *, NSString *> *s_customTextStyleNames;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_customTextStyleNames = @{ SRGAppearanceFontTextStyleCaption : @"Caption",
                                    SRGAppearanceFontTextStyleSubtitle : @"Subtitle",
                                    SRGAppearanceFontTextStyleBody : @"Body",
                                    SRGAppearanceFontTextStyleHeadline : @"Headline",
                                    SRGAppearanceFontTextStyleTitle : @"Title" };
    });
    return [self titlesForTextStyles:s_customTextStyleNames];
}

+ (NSArray<NSAttributedString *> *)titlesForTextStyles:(NSDictionary<NSString *, NSString *> *)textStyles
{
    NSMutableArray<NSAttributedString *> *titles = [NSMutableArray array];
    NSArray<NSString *> *textStylesKeys = [textStyles.allKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    for (NSString *textStyleKey in textStylesKeys) {
        UIFont *font = [UIFont srg_regularFontWithTextStyle:textStyleKey];
        NSString *titleString = [NSString stringWithFormat:@"%@ (%@)", textStyles[textStyleKey], @(font.pointSize)];
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleString attributes:@{ NSFontAttributeName : font }];
        [titles addObject:title];
    }
    return titles.copy;
}

#pragma mark Object lifecycle

- (instancetype)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"FontCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
    self.tableView.rowHeight = 60.f;
    [self reloadData];
}

#pragma mark Data

- (void)reloadData
{
    NSString *contentSizeCategoryShortName = [UIApplication.sharedApplication.preferredContentSizeCategory stringByReplacingOccurrencesOfString:@"UICTContentSizeCategory" withString:@""];
    self.title = [NSString stringWithFormat:@"%@ (%@)", NSLocalizedString(@"Fonts", nil), contentSizeCategoryShortName];
    
    self.customTitles = [FontsViewController titlesForCustomTextStyles];
    self.standardTitles = [FontsViewController titlesForStandardTextStyles];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return NSLocalizedString(@"Custom SRG SSR text styles", nil);
    }
    else {
        return NSLocalizedString(@"Standard text styles", nil);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.customTitles.count;
    }
    else {
        return self.standardTitles.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
}

#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAttributedString *title = nil;
    if (indexPath.section == 0) {
        title = self.customTitles[indexPath.row];
    }
    else {
        title = self.standardTitles[indexPath.row];
    }
    cell.textLabel.attributedText = title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self reloadData];
}

@end
