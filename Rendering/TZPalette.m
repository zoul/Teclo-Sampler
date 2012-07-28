#import "TZPalette.h"

@implementation TZPalette

+ (id) colorForSampleWithIndex: (NSUInteger) index
{
    NSArray *colors = @[
        [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1],
        [UIColor colorWithRed:0.03 green:0.41 blue:0.64 alpha:1],
        [UIColor colorWithRed:1.00 green:0.73 blue:0.00 alpha:1],
        [UIColor colorWithRed:1.00 green:0.25 blue:0.00 alpha:1],
        [UIColor colorWithRed:0.01 green:0.26 blue:0.42 alpha:1],
        [UIColor colorWithRed:0.00 green:0.65 blue:0.49 alpha:1],
        [UIColor colorWithRed:0.00 green:0.42 blue:0.32 alpha:1],
    ];
    return (index < [colors count]) ?
        [colors objectAtIndex:index] :
        nil;
}

@end
