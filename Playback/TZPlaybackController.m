#import "TZPlaybackController.h"
#import "TZSamplerPreset.h"

@interface TZPlaybackController ()
@property(strong) IBOutlet UIButton *holdButton;
@property(assign) NSUInteger lastSampleIndex;
@property(strong) NSMutableSet *heldSamples;
@end

@implementation TZPlaybackController
@synthesize holdButton, samplerPreset, heldSamples, lastSampleIndex;

#pragma mark Initialization

- (id) initWithNibName: (NSString*) nibNameOrNil bundle: (NSBundle*) nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setHeldSamples:[NSMutableSet set]];
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [holdButton setEnabled:NO];
}

#pragma mark Input

- (IBAction) sampleButtonDown: (UIButton*) button
{
    NSUInteger index = [button tag];
    NSLog(@"Button #%i down.", index);
    [self setLastSampleIndex:index];
    [[samplerPreset sampleAtIndex:index] play];
    [holdButton setBackgroundImage:
        [button backgroundImageForState:UIControlStateNormal]
        forState:UIControlStateNormal];
    [holdButton setEnabled:YES];
}

- (IBAction) sampleButtonUp: (UIButton*) button
{
    NSUInteger index = [button tag];
    NSLog(@"Button #%i up.", index);
    if (![heldSamples containsObject:@(index)]) {
        [[samplerPreset sampleAtIndex:index] stop];
        [[samplerPreset sampleAtIndex:index] setCurrentTime:0];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [button setHighlighted:YES];
        });
    }
    [holdButton setBackgroundImage:[UIImage imageNamed:@"tex0"] forState:UIControlStateNormal];
    [holdButton setEnabled:NO];
}

- (IBAction) toggleCurrentSampleHold
{
    NSNumber *index = @(lastSampleIndex);
    if ([heldSamples containsObject:index]) {
        NSLog(@"Unholding sample #%i.", lastSampleIndex);
        [heldSamples removeObject:index];
    } else {
        NSLog(@"Holding sample #%i.", lastSampleIndex);
        [heldSamples addObject:index];
    }
}

@end
