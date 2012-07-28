@class TZSamplerPreset;

@interface TZPlaybackController : UIViewController

@property(strong) TZSamplerPreset *samplerPreset;

- (IBAction) sampleButtonDown: (id) button;
- (IBAction) sampleButtonUp: (id) button;
- (IBAction) toggleCurrentSampleHold;

@end
