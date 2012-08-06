#import "TZSample.h"

@interface TZSample ()
@property(strong) AVAudioPlayer *player;
@end

@implementation TZSample
@synthesize player;

#pragma mark Initialization

- (id) initWithContentsOfURL: (NSURL*) fileURL error: (NSError**) error
{
    self = [super init];
    [self setPlayer:[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:error]];
    if (player) {
        [player setNumberOfLoops:-1];
        [player setEnableRate:YES];
        [player prepareToPlay];
        return self;
    } else {
        return nil;
    }
}

#pragma mark AVAudioPlayer Relay

- (void) play
{
    [player play];
}

- (void) stop
{
    [player stop];
}

- (float) rate
{
    return [player rate];
}

- (void) setRate: (float) rate
{
    [player setRate:rate];
}

- (BOOL) isPlaying
{
    return [player isPlaying];
}

- (NSTimeInterval) currentTime
{
    return [player currentTime];
}

- (void) setCurrentTime: (NSTimeInterval) currentTime
{
    [player setCurrentTime:currentTime];
}

@end
