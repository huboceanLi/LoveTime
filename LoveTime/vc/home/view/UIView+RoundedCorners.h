

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ShowBasicAnimationCorner)
{
    ShowBasicAnimationCornerTopLeft,
    ShowBasicAnimationCornerTopRight,
    ShowBasicAnimationCornerBottomLeft,
    ShowBasicAnimationCornerBottomRight,
};


@interface UIView (RoundedCorners)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii;
 
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect;


- (void)hideBasicAnimation: (CFTimeInterval)duration;

/// CAKeyframeAnimation, default values: @[@0, @1.03, @1.0]
- (void)showBasicAnimation: (CFTimeInterval)duration corner: (ShowBasicAnimationCorner) corner;


@end

NS_ASSUME_NONNULL_END
