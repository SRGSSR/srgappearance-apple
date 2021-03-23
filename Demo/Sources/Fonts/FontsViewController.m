//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "FontsViewController.h"

#import "Resources.h"

@import SRGAppearance;

@interface FontsViewController ()

@property (nonatomic) NSArray<NSAttributedString *> *textFontDescriptions;
@property (nonatomic) NSArray<NSAttributedString *> *displayFontDescriptions;

@end

@implementation FontsViewController

#pragma mark Class methods

+ (NSArray<NSAttributedString *> *)descriptionsForFontWithName:(SRGFontName)fontName
{
    static NSDictionary<NSNumber *, NSString *> *s_fontStyleNames;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_fontStyleNames = @{ @(SRGFontStyleTitle1) : @"Title1",
                              @(SRGFontStyleTitle2) : @"Title2",
                              @(SRGFontStyleHeadline1) : @"Headline1",
                              @(SRGFontStyleHeadline2) : @"Headline2",
                              @(SRGFontStyleSubtitle) : @"Subtitle",
                              @(SRGFontStyleBody) : @"Body",
                              @(SRGFontStyleButton1) : @"Button1",
                              @(SRGFontStyleButton2) : @"Button2",
                              @(SRGFontStyleOverline) : @"Overline",
                              @(SRGFontStyleLabel) : @"Label",
                              @(SRGFontStyleCaption) : @"Caption"
        };
    });
    return [self descriptionsForFontWithName:fontName styles:s_fontStyleNames];
}

+ (NSArray<NSAttributedString *> *)descriptionsForFontWithName:(SRGFontName)fontName styles:(NSDictionary<NSNumber *, NSString *> *)fontStyles
{
    NSMutableArray<NSAttributedString *> *titles = [NSMutableArray array];
    NSArray<NSNumber *> *fontStylesKeys = [fontStyles.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSNumber *fontStyleKey in fontStylesKeys) {
        UIFont *font = [SRGFont fontWithName:fontName style:fontStyleKey.integerValue relativeToTextStyle:UIFontTextStyleBody];
        NSString *titleString = [NSString stringWithFormat:@"%@ (%@)", fontStyles[fontStyleKey], @(font.pointSize)];
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
    
    self.textFontDescriptions = [FontsViewController descriptionsForFontWithName:SRGFontNameText];
    self.displayFontDescriptions = [FontsViewController descriptionsForFontWithName:SRGFontNameDisplay];
    
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
        return NSLocalizedString(@"Text Font", nil);
    }
    else {
        return NSLocalizedString(@"Display Font", nil);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.textFontDescriptions.count;
    }
    else {
        return self.displayFontDescriptions.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView dequeueReusableCellWithIdentifier:@"FontCell"];
}

#pragma mark UITableViewDelegate protocol

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        cell.textLabel.attributedText = self.textFontDescriptions[indexPath.row];
    }
    else {
        cell.textLabel.attributedText = self.displayFontDescriptions[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self reloadData];
}

@end
