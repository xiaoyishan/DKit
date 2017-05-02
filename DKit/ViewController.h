//
//  ViewController.h
//  DKit
//
//  Created by Sundear on 2017/4/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//
#import "NSObject+Safe.h"
#import "user.h"

#import <UIKit/UIKit.h>



#ifdef DEBUG
#define DLog(format, ...) printf("DLog[%s] %s\n", __TIME__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String])
#else
#define DLog(format, ...)
#endif

@interface ViewController : UIViewController



@end

