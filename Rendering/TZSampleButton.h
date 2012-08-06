@class TZSample;

@interface TZSampleButton : UIControl

@property(strong, nonatomic) TZSample *sample;
@property(assign, nonatomic) NSUInteger index;
@property(strong, nonatomic) UIColor *color;

@end
