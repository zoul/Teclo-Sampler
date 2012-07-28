@interface TZSamplerPreset : NSObject

+ (id) samplerPresetWithSamples: (NSDictionary*) samples;

- (void) setSample: (AVAudioPlayer*) sample atIndex: (NSUInteger) index;
- (AVAudioPlayer*) sampleAtIndex: (NSUInteger) index;

@end
