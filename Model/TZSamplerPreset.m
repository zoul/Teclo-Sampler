#import "TZSamplerPreset.h"

@interface TZSamplerPreset ()
@property(strong) NSMutableDictionary *samples;
@end

@implementation TZSamplerPreset
@synthesize samples;

#pragma mark Initialization

- (id) init
{
    self = [super init];
    [self setSamples:[NSMutableDictionary dictionary]];
    return self;
}

+ (id) samplerPresetWithSamples: (NSDictionary*) layout
{
    TZSamplerPreset *preset = [[self alloc] init];
    for (NSNumber *position  in [layout allKeys]) {
        NSString *sampleName = [layout objectForKey:position];
        NSURL *sampleURL = [[NSBundle mainBundle] URLForResource:sampleName withExtension:nil];
        AVAudioPlayer *sample = [[AVAudioPlayer alloc] initWithContentsOfURL:sampleURL error:NULL];
        [preset setSample:sample atIndex:[position unsignedIntegerValue]];
        [sample setEnableRate:YES];
        [sample setNumberOfLoops:-1];
        [sample prepareToPlay];
    }
    return preset;
}

#pragma mark Sample Management

- (void) setSample: (AVAudioPlayer*) sample atIndex: (NSUInteger) index
{
    if (sample) {
        [samples setObject:sample forKey:@(index)];
    } else {
        [samples removeObjectForKey:@(index)];
    }
}

- (AVAudioPlayer*) sampleAtIndex: (NSUInteger) index
{
    return [samples objectForKey:@(index)];
}

@end
