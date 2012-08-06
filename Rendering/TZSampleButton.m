#import "TZSampleButton.h"
#import "TZPalette.h"
#import "TZSample.h"

@implementation TZSampleButton
@synthesize sample, index, color;

#pragma mark Setters

- (void) setIndex: (NSUInteger) newIndex
{
    index = newIndex;
    [self setColor:[TZPalette colorForSampleWithIndex:newIndex]];
}

#pragma mark Drawing

- (void) drawRect: (CGRect) rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // Paint background
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);

    // Draw track number
    CGPoint labelOrigin = CGPointMake(rect.origin.x+2, rect.origin.y+2);
    NSString *label = [NSString stringWithFormat:@"%i%@", index, [sample isPlaying] ? @"✻" : @""];
    UIFont *labelFont = [UIFont boldSystemFontOfSize:15];
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    [label drawAtPoint:labelOrigin withFont:labelFont];

    // Draw hold indicator
    if ([sample isHeld]) {
        float holdIndicatorHeight = 20;
        CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
        CGContextFillRect(ctx, CGRectMake(0, CGRectGetHeight([self bounds])-holdIndicatorHeight, CGRectGetWidth([self bounds]), holdIndicatorHeight));
    }
}

@end
