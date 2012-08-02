#import "AppDelegate.h"
#import "TZAppFactory.h"

@implementation AppDelegate
@synthesize window;

- (BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [session setActive:YES error:NULL];
    [application setIdleTimerDisabled:YES];

    TZAppFactory *factory = [[TZAppFactory alloc] init];
    [self setWindow:[factory buildMainWindow]];
    [window makeKeyAndVisible];

    return YES;
}

@end
