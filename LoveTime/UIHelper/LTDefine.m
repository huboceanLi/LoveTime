//
//  LTDefine.m
//  LoveTime
//
//  Created by oceanMAC on 2023/12/5.
//

#import "LTDefine.h"

@implementation LTDefine

+ (void)popWithSender:(UINavigationController *)sender destination:(NSString *)destination {
    [self popWithSender:sender destination:destination animated:YES];
}

+ (void)dismissWhithDestination:(UIViewController *)destination{
    if (!destination) {
        return;
    }
    
    [destination dismissViewControllerAnimated:YES completion:nil];
}

+ (void)popWithSender:(UINavigationController *)sender destination:(NSString *)destination animated:(BOOL)animated {
    if (!sender) {
        return;
    }
    if (sender.viewControllers.count <= 0) {
        return;
    }
    if (destination.length == 0) {
        [sender popViewControllerAnimated:animated];
    }
    else {
        [sender.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([NSStringFromClass([obj class]) containsString:destination]) {
                [sender popToViewController:obj animated:animated];
                *stop = YES;
            }
        }];
    }
}

@end
