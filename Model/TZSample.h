@interface TZSample : NSObject

@property(readonly) BOOL isPlaying;
@property(assign, nonatomic) float rate;
@property(assign, nonatomic) NSTimeInterval currentTime;

- (id) initWithContentsOfURL: (NSURL*) fileURL error: (NSError**) error;

- (void) play;
- (void) stop;

@end
