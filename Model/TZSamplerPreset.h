@class TZSample;

@interface TZSamplerPreset : NSObject

+ (id) samplerPresetWithSamples: (NSDictionary*) samples;

- (void) setSample: (TZSample*) sample atIndex: (NSUInteger) index;
- (TZSample*) sampleAtIndex: (NSUInteger) index;

@end
