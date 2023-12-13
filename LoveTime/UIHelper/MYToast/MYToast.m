//
//  MYToast.m
//  MYERP
//
//  Created by chong on 2020/3/13.
//  Copyright © 2020 iMac. All rights reserved.
//

#import "MYToast.h"

@implementation MYToast

+ (void)onlyShowTextHUD:(nullable NSString *)text {
    [self onlyShowTextHUD:text position:QMUIToastViewPositionBottom];
}

+ (void)onlyShowTextHUD:(nullable NSString *)text inView:(UIView *)view {
    [self onlyShowTextHUD:text inView:view hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds position:QMUIToastViewPositionBottom];
}

+ (void)onlyShowTextHUD:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay position:(QMUIToastViewPosition)position {
    QMUITips *tips = [QMUITips createTipsToView:view];
    tips.userInteractionEnabled = NO;
    tips.toastPosition = position;
    QMUIToastContentView *contentView = (QMUIToastContentView *)tips.contentView;
    contentView.minimumSize = CGSizeMake(20, 36);
    contentView.insets = UIEdgeInsetsMake(2, 12, 10, 12);
    NSMutableDictionary * attributed = contentView.textLabelAttributes.mutableCopy;
    attributed[NSFontAttributeName] = UIFontMake(14);
    contentView.textLabelAttributes = attributed;

    if (position == QMUIToastViewPositionBottom) {
        tips.offset = CGPointMake(0, -40);
    }
    if (position == QMUIToastViewPositionTop) {
        tips.offset = CGPointMake(0, 40);
    }
    [tips showWithText:text hideAfterDelay:delay];
}

+ (void)onlyShowTextHUD:(nullable NSString *)text position:(QMUIToastViewPosition)position {
    [self onlyShowTextHUD:text inView:DefaultTipsParentView hideAfterDelay:QMUITipsAutomaticallyHideToastSeconds position:position];
}

@end
