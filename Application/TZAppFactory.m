#import "TZAppFactory.h"
#import "TZPlaybackController.h"

@implementation TZAppFactory

- (TZPlaybackController*) buildPlaybackController
{
    TZPlaybackController *controller = [[TZPlaybackController alloc] initWithNibName:nil bundle:nil];
    return controller;
}

- (UIViewController*) buildRootViewController
{
    UINavigationController *controller = [[UINavigationController alloc]
        initWithRootViewController:[self buildPlaybackController]];
    [controller setNavigationBarHidden:YES];
    return controller;
}

- (UIWindow*) buildMainWindow
{
    CGRect fullScreenFrame = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:fullScreenFrame];
    [window setRootViewController:[self buildRootViewController]];
    return window;
}

@end
