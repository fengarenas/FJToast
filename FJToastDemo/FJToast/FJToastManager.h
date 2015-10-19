//
//  FJToastManager.h
//  toast
//
//  Created by Feng_jun on 15/5/2.
//  Copyright (c) 2015年 Feng_jun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^callback)();

@interface FJToastManager : NSObject

+ (void)showToast:(NSString *)message;
+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration;
+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback;
+ (void)showToast:(NSString *)message duration:(NSTimeInterval)duration tapCallback:(callback)tapCallback complete:(callback)complete;
+ (void)hidden;

@end
