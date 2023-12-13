//
//  MYToast.h
//  MYERP
//
//  Created by chong on 2020/3/13.
//  Copyright © 2020 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QMUIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYToast : NSObject

+ (void)onlyShowTextHUD:(nullable NSString *)text;
+ (void)onlyShowTextHUD:(nullable NSString *)text inView:(UIView *)view;
+ (void)onlyShowTextHUD:(nullable NSString *)text inView:(UIView *)view hideAfterDelay:(NSTimeInterval)delay position:(QMUIToastViewPosition)position;
+ (void)onlyShowTextHUD:(nullable NSString *)text position:(QMUIToastViewPosition)position;

@end

NS_ASSUME_NONNULL_END
