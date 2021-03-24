//
//  Copyright (c) SRG SSR. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "PlaygroundViewController.h"

#import "Resources.h"

@import SRGAppearance;

@interface PlaygroundViewController ()

@property (nonatomic, weak) IBOutlet UILabel *textLabel;

@property (nonatomic, weak) IBOutlet UISegmentedControl *typeSegmentedControl;
@property (nonatomic, weak) IBOutlet UISlider *sizeSlider;
@property (nonatomic, weak) IBOutlet UISlider *maximumSizeSlider;
@property (nonatomic, weak) IBOutlet UISlider *weightSlider;

@end

@implementation PlaygroundViewController

#pragma mark Object lifecycle

- (instancetype)init
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:ResourceNameForUIClass(self.class) bundle:nil];
    return storyboard.instantiateInitialViewController;
}

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // iOS 14 bug: Values set in the storyboard are incorrect. Force them again.
    if (@available(iOS 14, *)) {
        self.sizeSlider.value = 24.f;
        self.maximumSizeSlider.value = self.maximumSizeSlider.maximumValue;
        self.weightSlider.value = 0.f;
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Close", nil)
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(close:)];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(contentSizeCategoryDidChange:)
                                               name:UIContentSizeCategoryDidChangeNotification
                                             object:nil];
    
    [self updateFont];
}

#pragma mark Getters and setters

- (NSString *)title
{
    return NSLocalizedString(@"Playground", nil);
}

- (SRGFontType)fontType
{
    return (self.typeSegmentedControl.selectedSegmentIndex == 1) ? SRGFontTypeDisplay : SRGFontTypeText;
}

#pragma mark Fonts

- (void)updateFont
{
    self.textLabel.font = [SRGFont fontWithType:[self fontType]
                                         weight:self.weightSlider.value
                                           size:self.sizeSlider.value
                                    maximumSize:self.maximumSizeSlider.value
                            relativeToTextStyle:UIFontTextStyleBody];
}

#pragma mark Actions

- (IBAction)changeType:(id)sender
{
    [self updateFont];
}

- (IBAction)changeSize:(id)sender
{
    [self updateFont];
}

- (IBAction)changeMaximumSize:(id)sender
{
    [self updateFont];
}

- (IBAction)changeWeight:(id)sender
{
    [self updateFont];
}

- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Notifications

- (void)contentSizeCategoryDidChange:(NSNotification *)notification
{
    [self updateFont];
}

@end
