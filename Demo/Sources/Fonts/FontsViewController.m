//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "FontsViewController.h"

#import "Resources.h"

@import SRGAppearance;

@interface FontsViewController ()

@property (nonatomic) NSArray<NSAttributedString *> *customTitles;

@end

@implementation FontsViewController

#pragma mark Class methods

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
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource protocol

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"SRG SSR regular font with appearance text styles", nil);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.customTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
}

#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.attributedText = self.customTitles[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self reloadData];
}

@end
