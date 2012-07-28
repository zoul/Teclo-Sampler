#import "TZAppFactory.h"

@implementation TZAppFactory

- (UIViewController*) buildRootViewController
{
    return nil;
}

- (UIWindow*) buildMainWindow
{
    CGRect fullScreenFrame = [[UIScreen mainScreen] bounds];
    return [[UIWindow alloc] initWithFrame:fullScreenFrame];
}

@end
