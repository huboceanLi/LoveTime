

#import "UIView+RoundedCorners.h"

@implementation UIView (RoundedCorners)
- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)addRoundedCorners:(UIRectCorner)corners
                withRadii:(CGSize)radii
                 viewRect:(CGRect)rect {
    
    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    
    self.layer.mask = shape;
}

- (void)hideBasicAnimation:(CFTimeInterval)duration {
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = duration;
    anim.repeatCount = 1;
    anim.fromValue = @1.0;
    anim.toValue = @0.0;
    anim.removedOnCompletion = false;
    anim.fillMode = @"forwards";

    [self.layer addAnimation:anim forKey: @"scale-remove-layer"];
    
    
    NSString *key = @"scale-show-layer";
    if ([self.layer.animationKeys containsObject: key]) {
        [self.layer removeAnimationForKey: key];
    }
    
}


- (void)showBasicAnimation:(CFTimeInterval)duration corner:(ShowBasicAnimationCorner)corner {
    
    CGRect oldFrame = self.frame ;
    
    if (corner == ShowBasicAnimationCornerTopLeft) {
        self.layer.anchorPoint = CGPointMake(0.1f, 0.0f);
    } else if (corner == ShowBasicAnimationCornerTopRight) {
        self.layer.anchorPoint = CGPointMake(0.95f, 0.0f);
    } else if (corner == ShowBasicAnimationCornerBottomLeft) {
        self.layer.anchorPoint = CGPointMake(0.1f, 1.0f);
    } else if (corner == ShowBasicAnimationCornerBottomRight) {
        self.layer.anchorPoint = CGPointMake(0.95f, 1.0f);
    }
    
    
    self.frame = oldFrame;
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = duration;
    anim.repeatCount = 1;
    anim.removedOnCompletion = false;
    anim.fillMode = @"forwards";
    anim.values = @[@0.2, @1.03, @1.0];
    anim.timingFunctions = @[[CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:anim forKey:@"scale-show-layer"];
    
    NSString *key = @"scale-remove-layer";
    if ([self.layer.animationKeys containsObject: key]) {
        [self.layer removeAnimationForKey: key];
    }
}

@end
