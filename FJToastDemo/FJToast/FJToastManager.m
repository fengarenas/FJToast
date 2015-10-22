// Copyright (c) 2015 FJToast
// Author fengjun
// Blog:http://devfeng.com/
// Url :https://github.com/fengarenas/FJToast
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
