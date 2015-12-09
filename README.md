# FJToast

类似Android的toast提示控件

## Install

```
import "FJToast.h"
```

## Usage

```

[FJToast showToast:@"message"];

[FJToast showToast:@"message 5 second" duration:5.0f];

[FJToast showToast:@"message taped execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}];
                              
[FJToast showToast:@"message taped or completed execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}
                             complete:^{
                                 NSLog(@"toast completed");}];

[FJToast showToast:@"message until finish it" duration:0];
[FJToast hidden];

```

## Author
**FengJun** e-mail:<fengarenas@126.com> Blog:[DevFeng](http://devfeng.com/)
