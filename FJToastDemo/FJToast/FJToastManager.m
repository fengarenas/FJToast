//
//  FJToastManager.m
//  toast
//
//  Created by Feng_jun on 15/5/2.
//  Copyright (c) 2015年 Feng_jun. All rights reserved.
//

#import "FJToastManager.h"
#import "FJToastView.h"

static const NSTimeInterval FJDefaultDuration = 3.0f;

@implementation FJToastManager

+ (void)showToast:(NSString *)message {
    [self showToast:message duration:FJDefaultDuration];
}

+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration {
    [self showToast:message duration:duration tapCallback:nil];
}

+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback {
    [self showToast:message duration:duration tapCallback:tapCallback complete:nil];
}

+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback complete:(callback)complete {
    FJToastView *toastView = [[FJToastView alloc]initWithMessage:message duration:duration tapCallback:tapCallback complete:complete];
    
    UIWindow *topWindow = [[UIApplication sharedApplication].windows lastObject];
    for (UIView *v in topWindow.subviews) {
        if ([v isMemberOfClass:[toastView class]]) {
            [v removeFromSuperview];
        }
    }
    [topWindow addSubview:toastView];
    [toastView show];
}


+ (void)hidden {
    UIWindow *topWindow = [[UIApplication sharedApplication].windows lastObject];
    for (UIView *v in topWindow.subviews) {
        if ([v isMemberOfClass:[FJToastView class]]) {
            FJToastView *toast = (FJToastView *)v;
            [toast hidden];
        }
    }
}


@end
