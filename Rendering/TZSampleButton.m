#import "TZSampleButton.h"
#import "TZPalette.h"

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
    NSString *label = [NSString stringWithFormat:@"%i%@", index, [sample isPlaying] ? @"➤" : @""];
    UIFont *labelFont = [UIFont boldSystemFontOfSize:15];
    CGContextSetFillColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    [label drawAtPoint:labelOrigin withFont:labelFont];
}

@end
