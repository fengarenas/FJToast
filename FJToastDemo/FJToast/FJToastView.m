//
// Copyright (c) 2013 FJToast
// Author:FengJun(http://devfeng.com/)
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

#import "FJToastView.h"
#import <objc/runtime.h>



#define kScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight      ([UIScreen mainScreen].bounds.size.height)
#define kSystemVersion     ([[UIDevice currentDevice].systemVersion floatValue])
#define kTextLabelMaxWidth (kScreenWidth * 0.8f)

static const CGFloat kLeftPadding   = 10.0f;
static const CGFloat kRightPadding  = 10.0f;
static const CGFloat kTopPadding    = 10.0f;
static const CGFloat kBottomPadding = 10.0f;

static const NSTimeInterval FJToastFadeDuration = 0.2;

static const CGFloat FJToastCornerRadius = 5.0;
static const CGFloat FJToastFontSize = 15.0;
static const CGFloat FJToastMaxMessageLines     = 0;

static const NSString *FJToastTimerKey          = @"FJToastTimerKey";
static const NSString *FJToastTapKey            = @"FJToastTapKey";
static const NSString *FJToastCompleteKey       = @"FJToastCompleteKey";


@implementation FJToastView

#pragma mark - lifeCycle

- (instancetype)initWithMessage:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback complete:(callback)complete {
    self = [super init];
    if (!self) return nil;
    
    if (!message) return nil;
    
    self.backgroundColor = [UIColor blackColor];
    self.layer.cornerRadius = FJToastCornerRadius;
    self.layer.masksToBounds = YES;
    self.alpha = 0.0f;
    
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.font = [UIFont systemFontOfSize:FJToastFontSize];
    messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
    messageLabel.text = message;
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = FJToastMaxMessageLines;
    
    CGSize messageSize = [self sizeForString:message font:messageLabel.font constrainedToSize:CGSizeMake(kTextLabelMaxWidth, kScreenHeight) lineBreakMode:messageLabel.lineBreakMode];
    
    messageLabel.frame = CGRectMake(kLeftPadding, kTopPadding , messageSize.width, messageSize.height);
    self.frame = CGRectMake(0, 0, messageSize.width + kLeftPadding + kRightPadding, messageSize.height + kTopPadding + kBottomPadding);
    [self addSubview:messageLabel];
    self.center = CGPointMake(kScreenWidth / 2.0f, kScreenHeight / 2.0f);
    
    //event
    if (duration) {
        if (tapCallback) {
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toastTaped)];
            [self addGestureRecognizer:tapGes];
            objc_setAssociatedObject(self, &FJToastTapKey, tapCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
        }
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastCompleted:) userInfo:nil repeats:NO];
        objc_setAssociatedObject(self, &FJToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (complete) {
        objc_setAssociatedObject(self, &FJToastCompleteKey, complete, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    
    return self;
}

#pragma mark - response methon

- (void)toastTaped {
    callback tapCallback = objc_getAssociatedObject(self, &FJToastTapKey);
    if (tapCallback) tapCallback();
    
    callback complete = objc_getAssociatedObject(self, &FJToastCompleteKey);
    if (complete) complete();
    
    NSTimer *timer = objc_getAssociatedObject(self, &FJToastTimerKey);
    if (timer) [timer invalidate];
    
    [self hidden];
}

- (void)toastCompleted:(NSTimer *)timer {
    callback complete = objc_getAssociatedObject(self, &FJToastCompleteKey);
    if (complete) complete();
    if (timer) [timer invalidate];
    [self hidden];
}

- (void)show {
    [UIView animateWithDuration:FJToastFadeDuration
                     animations:^{self.alpha = 1.0f;}
                     completion:nil];
}

- (void)hidden {
    [UIView animateWithDuration:FJToastFadeDuration
                     animations:^{self.alpha = 0.0f;}
                     completion:^(BOOL finished) {[self removeFromSuperview];}];
}

#pragma mark - utils

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attribute = @{NSFontAttributeName : font,NSParagraphStyleAttributeName : paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        return boundingRect.size;
    }
    
#pragma clang diagnostic push
#pragma clong diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop

}
@end
