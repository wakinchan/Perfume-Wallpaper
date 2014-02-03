#import "PerfumeWallpaper.h"
#define _4inch  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568.0

static const float kImageWidth = 72.0;
static const float kSemiImageWidth = 36.0;
static const float kImageHeight = 144.0;

@interface PerfumeWallpaper ()
@end

@implementation PerfumeWallpaper

@synthesize delegate = _delegate;

+ (NSString *)identifier
{
    return @"PerfumeWallpaper";
}

+ (BOOL)colorChangesSignificantly
{
    return YES;
}

+ (NSArray *)presetWallpaperOptions
{
    return @[
             @{ @"kSBUIMagicWallpaperThumbnailNameKey": @"Preview",@"info": @"1" },
             ];
}

- (void)setWallpaperOptions:(NSDictionary *)options
{

}

- (void)setWallpaperVariant:(int)variant
{
    
}

- (UIView *)view
{
    return self;
}

#pragma mark - Wallpaper implementation

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"legibilitySettingsBlack" object:self];
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    if (_4inch)
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:@"LockBackgroundNone-568@2x" ofType:@"png"]]];
    else
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:@"LockBackgroundNone@2x" ofType:@"png"]]];

    hh0 = [[UIImageView alloc] init];
    hh0.frame = CGRectMake(0, 0, kImageWidth, kImageHeight);
    hh1 = [[UIImageView alloc] init];
    hh1.frame = CGRectMake(72, 0, kImageWidth, kImageHeight);
    mm0 = [[UIImageView alloc] init];
    mm0.frame = CGRectMake(180, 0, kImageWidth, kImageHeight);
    mm1 = [[UIImageView alloc] init];
    mm1.frame = CGRectMake(252, 0, kImageWidth, kImageHeight);
    ss0 = [[UIImageView alloc] init];
    ss0.frame = CGRectMake(360, 0, kImageWidth, kImageHeight);
    ss1 = [[UIImageView alloc] init];
    ss1.frame = CGRectMake(432, 0, kImageWidth, kImageHeight);

    semi0 = [[UIImageView alloc] init];
    semi0.frame = CGRectMake(144, 0, kSemiImageWidth, kImageHeight);
    semi1 = [[UIImageView alloc] init];
    semi1.frame = CGRectMake(324, 0, kSemiImageWidth, kImageHeight);

    /*** 
    note: To abuse the SpringBoard If you use a millisecond! CPU 80% over..
    (NSTimer: TimeInterval 0.01)

    mb0 = [[UIImageView alloc] init];
    mb0.frame = CGRectMake(536, 0, kImageWidth, kImageHeight);
    mb1 = [[UIImageView alloc] init];
    mb1.frame = CGRectMake(608, 0, kImageWidth, kImageHeight);
    semi2 = [[UIImageView alloc] init];
    semi2.frame = CGRectMake(504, 0, kSemiImageWidth, kImageHeight);
    */

    dome = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[bundle pathForResource:@"dome_circle" ofType:@"png"]]];
    dome.frame = CGRectMake(self.frame.size.width/2-160, self.frame.size.height/2-160, 320, 320);

    UIView *view = [[UIView alloc] init];
    view.transform = CGAffineTransformMakeScale(0.55, 0.55);
    view.contentMode = UIViewContentModeScaleAspectFit;
    view.frame = CGRectMake(21.4, 50, 504*0.55, kImageHeight*0.55);

    [view addSubview:hh1];
    [view addSubview:mm0];
    [view addSubview:mm1];
    [view addSubview:ss0];
    [view addSubview:ss1];
    [view addSubview:semi0];
    [view addSubview:semi1];

    [self addSubview:dome];
    [self addSubview:view];
    
    return self;
}

- (void)update
{
    NSArray *imageNames = [self getClockImageNames];
    NSLog(@"imageNames: %@", imageNames);

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    hh0.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[0]] ofType:@"png"]];
    hh1.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[1]] ofType:@"png"]];
    mm0.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[2]] ofType:@"png"]];
    mm1.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[3]] ofType:@"png"]];
    ss0.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[4]] ofType:@"png"]];
    ss1.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", imageNames[5]] ofType:@"png"]];

    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss"];
    if ([[formatter stringFromDate:now] intValue] % 2 == 0) {
        semi0.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", [self getClockSemiImageName]] ofType:@"png"]];
        semi1.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:[NSString stringWithFormat:@"Clocks-white/%@", [self getClockSemiImageName]] ofType:@"png"]];
        [self imageFadeIn:semi0];
        [self imageFadeIn:semi1];
    } else if ([[formatter stringFromDate:now] intValue] % 2 == 1) {
        [self imageFadeOut:semi0];
        [self imageFadeOut:semi1];
    }
}

- (void)imageFadeIn:(UIImageView*)view
{
    view.alpha = 0.3;
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2.f];
    view.alpha = 1;
    [UIView commitAnimations];
}

- (void)imageFadeOut:(UIImageView*)view
{
    [UIView beginAnimations:@"fadeOut" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:2.f];
    view.alpha = 0;
    [UIView commitAnimations];
}

- (NSArray *)getClockImageNames
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSString *date = [formatter stringFromDate:now];
    NSArray *nums = @[@"35", @"26", @"27", @"31", @"28", @"23", @"24", @"31", @"33", @"47"];

    NSMutableArray *images = [NSMutableArray array];
    for (unsigned int i=0; i<6; i++) {
        int datenum = [[date substringWithRange:NSMakeRange(i,1)] intValue];
        int randnum = arc4random() % [nums[datenum] intValue];
        images[i] = [NSString stringWithFormat:@"%d_%d", datenum, randnum];
    }

    return [images mutableCopy];
}


- (NSString *)getClockSemiImageName
{
    return [NSString stringWithFormat:@"semi_%d", arc4random() % 22]; // xxx: semi_xx 22 pattern files
}

- (void)setAnimating:(BOOL)animating
{
    if (animating) {
        if (!self.updateTimer) {
            [self update];
            self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.updateTimer forMode:NSRunLoopCommonModes];
        }
    } else {
        if (self.updateTimer) {
            [self.updateTimer invalidate];
            self.updateTimer = nil;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
