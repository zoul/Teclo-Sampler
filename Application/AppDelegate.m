#import "AppDelegate.h"
#import "TZAppFactory.h"

@implementation AppDelegate
@synthesize window;

- (BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions
{
    TZAppFactory *factory = [[TZAppFactory alloc] init];
    [self setWindow:[factory buildMainWindow]];
    [application setIdleTimerDisabled:YES];
    [window makeKeyAndVisible];
    return YES;
}

@end
