#import "TZPlaybackController.h"
#import "TZSamplerPreset.h"
#import "TZSampleButton.h"
#import "TZSample.h"

@interface TZPlaybackController ()
@property(strong) IBOutlet UIButton *holdButton;
@property(strong) IBOutletCollection(TZSampleButton) NSArray *sampleButtons;
@property(strong) UISlider *tempoSlider;
@property(assign) NSUInteger lastSampleIndex;
@end

@implementation TZPlaybackController
@synthesize holdButton, samplerPreset, lastSampleIndex, sampleButtons, tempoSlider;

#pragma mark Initialization

- (void) viewDidLoad
{
    [super viewDidLoad];
    [holdButton setEnabled:NO];

    for (TZSampleButton *button in sampleButtons) {
        [button addTarget:self
            action:@selector(sampleButtonDown:)
            forControlEvents:UIControlEventTouchDown];
        [button addTarget:self
            action:@selector(sampleButtonUp:)
            forControlEvents:UIControlEventTouchUpInside];
        [button setSample:[samplerPreset sampleAtIndex:[button tag]]];
        [button setIndex:[button tag]];
    }

    [self setTempoSlider:[[UISlider alloc] init]];
    [tempoSlider setFrame:CGRectMake(-92, 158, 292, 20)];
    [tempoSlider setMaximumValue:2];
    [tempoSlider setMinimumValue:0.001];
    [tempoSlider setMinimumTrackTintColor:[UIColor grayColor]];
    [tempoSlider setEnabled:NO];
    [tempoSlider setValue:1];
    [tempoSlider setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
    [tempoSlider addTarget:self action:@selector(changeCurrentSampleTempo:)
        forControlEvents:UIControlEventValueChanged];
    [[self view] addSubview:tempoSlider];
}

#pragma mark Input

- (IBAction) sampleButtonDown: (TZSampleButton*) button
{
    NSUInteger index = [button index];
    NSLog(@"Button #%i down.", index);

    TZSample *sample = [samplerPreset sampleAtIndex:index];
    [self setLastSampleIndex:index];

    // Could be already playing if held
    if (![sample isPlaying]) {
        [sample play];
        [button setNeedsDisplay];
    }

    [tempoSlider setValue:[sample rate]];
    [tempoSlider setMinimumTrackTintColor:[button color]];
    [tempoSlider setEnabled:YES];

    [holdButton setBackgroundColor:[button color]];
    [holdButton setEnabled:YES];
}

- (IBAction) sampleButtonUp: (TZSampleButton*) button
{
    NSUInteger index = [button index];
    TZSample *sample = [samplerPreset sampleAtIndex:index];
    NSLog(@"Button #%i up.", index);

    if (![sample isHeld]) {
        [sample stop];
        [sample setCurrentTime:0];
        [button setNeedsDisplay];
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
    TZSample *sample = [samplerPreset sampleAtIndex:lastSampleIndex];
    if ([sample isHeld]) {
        NSLog(@"Unholding sample #%i.", lastSampleIndex);
        [sample setHeld:NO];
    } else {
        NSLog(@"Holding sample #%i.", lastSampleIndex);
        [sample setHeld:YES];
    }
}

- (IBAction) changeCurrentSampleTempo: (UISlider*) sender
{
    [[samplerPreset sampleAtIndex:lastSampleIndex] setRate:[sender value]];
}

@end
