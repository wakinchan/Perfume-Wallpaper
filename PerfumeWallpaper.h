#import <UIKit/UIKit.h>
#import "SBFProceduralWallpaper.h"

@interface PerfumeWallpaper : UIView <SBFProceduralWallpaper>
{
    UIImageView* clockView;
    UIImageView *hh0;
    UIImageView *hh1;
    UIImageView *mm0;
    UIImageView *mm1;
    UIImageView *ss0;
    UIImageView *ss1;
    UIImageView *mb0;
    UIImageView *mb1;
    UIImageView *semi0;
    UIImageView *semi1;
    UIImageView *semi2;
    UIImageView *symbol;
}
@property (nonatomic, retain)NSTimer* updateTimer;
@property (nonatomic, retain)NSTimer* spinTimer;

- (void)update;
- (void)spin;
- (void)stopSpin;
- (void)imageFadeIn:(UIImageView*)view;
- (void)imageFadeOut:(UIImageView*)view;
- (NSArray *)getClockImageNames;
- (NSString *)getClockSemiImageName;
- (NSString *)getNowDateWithFormat:(NSString *)format;
@end
