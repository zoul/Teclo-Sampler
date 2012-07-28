#import "TZPlaybackController.h"

@interface TZPlaybackController ()
@property(strong) IBOutlet UIButton *holdButton;
@end

@implementation TZPlaybackController
@synthesize holdButton;

#pragma mark Initialization

- (void) viewDidLoad
{
    [super viewDidLoad];
    [holdButton setEnabled:NO];
}

#pragma mark Input

- (IBAction) sampleButtonDown: (UIButton*) button
{
    NSLog(@"Button #%i down.", [button tag]);
    [holdButton setEnabled:YES];
}

- (IBAction) sampleButtonUp: (UIButton*) button
{
    NSLog(@"Button #%i up.", [button tag]);
    [holdButton setEnabled:NO];
}

- (IBAction) toggleCurrentSampleHold
{
    NSLog(@"(Un)holding current sample.");
}

@end
