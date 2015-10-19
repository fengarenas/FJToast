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

#import "ViewController.h"
#import "FJToastManager.h"

#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

static const NSUInteger buttonCount   = 6;
static const NSUInteger buttonBaseTag = 10000;

@interface ViewController ()

@property (nonatomic, copy) NSArray *buttonTitles;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initButtons];
}

- (void)initButtons {
    for (int i = 0; i < buttonCount; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0,50 + i * 50, kScreenWidth, 30)];
        button.layer.cornerRadius = 3.0;
        button.layer.borderColor = [UIColor purpleColor].CGColor;
        button.layer.borderWidth = 1.0;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        [button setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        button.tag = buttonBaseTag + i;
        [button addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (IBAction)btnTaped:(UIButton *)sender {
    switch (sender.tag) {
        case buttonBaseTag + 0: {
            [FJToastManager showToast:@"message"];
        }
            break;
        case buttonBaseTag + 1: {
            [FJToastManager showToast:@"message 5 second"
                             duration:5.0f];
        }
            break;
        case buttonBaseTag + 2: {
            [FJToastManager showToast:@"message taped execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}];
        }
            break;
        case buttonBaseTag + 3: {
            [FJToastManager showToast:@"message taped or completed execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}
                             complete:^{
                                 NSLog(@"toast completed");}];
        }
            break;
        case buttonBaseTag + 4: {
            [FJToastManager showToast:@"message until finish it" duration:0];
        }
            break;
        case buttonBaseTag + 5: {
            [FJToastManager hidden];
        }
            break;
            
        default:
            [FJToastManager hidden];
            break;
    }
    
}

#pragma mark - Getter and Setter methon

-(NSArray *)buttonTitles {
    return @[ @"default toast",@"toast with 5s duration",@"toast with tapCallback",@"toast tap and comlete callback",@"toast no exit",@"exit toast" ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
