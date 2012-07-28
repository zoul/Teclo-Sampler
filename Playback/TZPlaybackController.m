#import "TZPlaybackController.h"
#import "TZSamplerPreset.h"
#import "TZPalette.h"

@interface TZPlaybackController ()
@property(strong) IBOutlet UIButton *holdButton;
@property(strong) IBOutletCollection(UIButton) NSArray *sampleButtons;
@property(strong) UISlider *tempoSlider;
@property(assign) NSUInteger lastSampleIndex;
@property(strong) NSMutableSet *heldSamples;
@end

@implementation TZPlaybackController
@synthesize holdButton, samplerPreset, heldSamples, lastSampleIndex, sampleButtons, tempoSlider;

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

    for (UIButton *button in sampleButtons)
        [button setBackgroundColor:[TZPalette colorForSampleWithIndex:[button tag]]];

    [self setTempoSlider:[[UISlider alloc] init]];
    [tempoSlider setFrame:CGRectMake(-90, 152, 290, 20)];
    [tempoSlider setMaximumValue:2];
    [tempoSlider setMinimumValue:0.001];
    [tempoSlider setMinimumTrackTintColor:[UIColor grayColor]];
    [tempoSlider setValue:1];
    [tempoSlider setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    [tempoSlider addTarget:self action:@selector(changeCurrentSampleTempo:)
        forControlEvents:UIControlEventValueChanged];
    [[self view] addSubview:tempoSlider];

    [holdButton setEnabled:NO];
    [tempoSlider setEnabled:NO];
}

#pragma mark Input

- (IBAction) sampleButtonDown: (UIButton*) button
{
    NSUInteger index = [button tag];
    NSLog(@"Button #%i down.", index);

    AVAudioPlayer *sample = [samplerPreset sampleAtIndex:index];
    [self setLastSampleIndex:index];

    // Could be already playing if held
    if (![sample isPlaying]) {
        [sample play];
    }

    [tempoSlider setValue:[sample rate]];
    [tempoSlider setMinimumTrackTintColor:[button backgroundColor]];
    [tempoSlider setEnabled:YES];

    [holdButton setBackgroundColor:[button backgroundColor]];
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

    [tempoSlider setValue:1];
    [tempoSlider setMinimumTrackTintColor:[UIColor grayColor]];
    [tempoSlider setEnabled:NO];

    [holdButton setBackgroundColor:[UIColor grayColor]];
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

- (IBAction) changeCurrentSampleTempo: (UISlider*) sender
{
    [[samplerPreset sampleAtIndex:lastSampleIndex] setRate:[sender value]];
}

@end
