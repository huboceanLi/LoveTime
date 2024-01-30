//
//  LTDefine.h
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LTDefine : NSObject

+ (void)popWithSender:(UINavigationController *)sender destination:(NSString *)destination;
+ (void)dismissWhithDestination:(UIViewController *)destination;

@end

NS_ASSUME_NONNULL_END
