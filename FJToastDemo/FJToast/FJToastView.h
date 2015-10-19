//
//  FJToastView.h
//  toast
//
//  Created by Feng_jun on 15/5/2.
//  Copyright (c) 2015年 Feng_jun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callback)();

@interface FJToastView : UIView

- (instancetype)initWithMessage:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback complete:(callback)complete;
- (void)show;
- (void)hidden;

@end
