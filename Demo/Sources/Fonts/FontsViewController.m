//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "FontsViewController.h"

#import "PlaygroundViewController.h"
#import "Resources.h"
#import "SRGAppearance_demo-Swift.h"

@import SRGAppearance;

@interface FontsViewController ()

@property (nonatomic) NSArray<NSAttributedString *> *textFontDescriptions;
@property (nonatomic) NSArray<NSAttributedString *> *displayFontDescriptions;

@end

@implementation FontsViewController

#pragma mark Class methods

+ (NSArray<NSAttributedString *> *)descriptionsForFontWithFamily:(SRGFontFamily)family
{
    static NSDictionary<NSNumber *, NSString *> *styles;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        styles = @{ @(SRGFontStyleTitle1) : @"Title1",
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
    return [self descriptionsForFontWithFamily:family styles:styles];
}

+ (NSArray<NSAttributedString *> *)descriptionsForFontWithFamily:(SRGFontFamily)family styles:(NSDictionary<NSNumber *, NSString *> *)styles
{
    NSMutableArray<NSAttributedString *> *titles = [NSMutableArray array];
    NSArray<NSNumber *> *stylesKeys = [styles.allKeys sortedArrayUsingSelector:@selector(compare:)];
    for (NSNumber *styleKey in stylesKeys) {
        UIFont *font = [SRGFont fontWithFamily:family style:styleKey.integerValue];
        NSString *titleString = [NSString stringWithFormat:@"%@ (%@)", styles[styleKey], @(font.pointSize)];
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
    
#if TARGET_OS_IOS
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Playground", nil)
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(openPlayground:)];
#endif
    
    self.tableView.rowHeight = 60.f;
    [self reloadData];
}

#pragma mark Data

- (void)reloadData
{
    NSString *contentSizeCategoryShortName = [UIApplication.sharedApplication.preferredContentSizeCategory stringByReplacingOccurrencesOfString:@"UICTContentSizeCategory" withString:@""];
    self.title = [NSString stringWithFormat:@"%@ (%@)", NSLocalizedString(@"Fonts", nil), contentSizeCategoryShortName];
    
    self.textFontDescriptions = [FontsViewController descriptionsForFontWithFamily:SRGFontFamilyText];
    self.displayFontDescriptions = [FontsViewController descriptionsForFontWithFamily:SRGFontFamilyDisplay];
    
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

#if TARGET_OS_IOS

#pragma mark Actions

- (IBAction)openPlayground:(id)sender
{
    // The playground is implemented in SwiftUI for iOS 13+
    UIViewController *playgroundViewController = nil;
    if (@available(iOS 13.0, *)) {
        playgroundViewController = [[PlaygroundHostViewController alloc] init];
    }
    else {
        playgroundViewController = [[PlaygroundViewController alloc] init];
    }
    UINavigationController *playgroundNavigationController = [[UINavigationController alloc] initWithRootViewController:playgroundViewController];
    [self presentViewController:playgroundNavigationController animated:YES completion:nil];
}

#endif

#pragma mark Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self reloadData];
}

@end
