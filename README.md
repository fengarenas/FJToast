# FJToast

a simple toast demo

## Install

```
import "FJToastManager.h"
```

## Usage

```

[FJToastManager showToast:@"message"];

[FJToastManager showToast:@"message 5 second" duration:5.0f];

[FJToastManager showToast:@"message taped execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}];
                              
[FJToastManager showToast:@"message taped or completed execute code"
                             duration:3.0f
                          tapCallback:^{
                              NSLog(@"toast taped");}
                             complete:^{
                                 NSLog(@"toast completed");}];

[FJToastManager showToast:@"message until finish it" duration:0];
[FJToastManager hidden];

```

## Author
**FengJun** e-mail:<fengarenas@126.com> Blog:[DevFeng](http://devfeng.com/)
