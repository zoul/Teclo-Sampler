#import "TZAppFactory.h"
#import "TZPlaybackController.h"
#import "TZSamplerPreset.h"

@implementation TZAppFactory

#pragma mark Model

- (TZSamplerPreset*) buildDefaultSamplerPreset
{
    return [TZSamplerPreset samplerPresetWithSamples:@{
        @1: @"1.wav",
        @2: @"2.wav",
        @3: @"3.wav",
        @4: @"4.wav",
        @5: @"sitar.wav",
        @6: @"sitar.wav",
    }];
}

#pragma mark UI Components

- (TZPlaybackController*) buildPlaybackController
{
    TZPlaybackController *controller = [[TZPlaybackController alloc] initWithNibName:nil bundle:nil];
    [controller setSamplerPreset:[self buildDefaultSamplerPreset]];
    return controller;
}

- (UIViewController*) buildRootViewController
{
    UINavigationController *controller = [[UINavigationController alloc]
        initWithRootViewController:[self buildPlaybackController]];
    [controller setNavigationBarHidden:YES];
    return controller;
}

#pragma mark Public UI Components

- (UIWindow*) buildMainWindow
{
    CGRect fullScreenFrame = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:fullScreenFrame];
    [window setRootViewController:[self buildRootViewController]];
    return window;
}

@end
