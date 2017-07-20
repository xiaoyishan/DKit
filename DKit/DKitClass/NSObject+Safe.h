//
//  NSObject+Safe.h
//  DKit
//
//  Created by Sundear on 2017/4/27.
//  Copyright © 2017年 xiexin. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Safe)

/* 将所有与model不匹配或nil null的值规范化或初始化 */
-(void)SafeModel;


/* 置空所有数据，再将其初始化 */
-(void)ClearModel;


@end
