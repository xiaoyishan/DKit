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

#import "UIKit+NotNull.h"


//模糊匹配等级 前后缀list由本class提供自定义数据 可自行增删
typedef NS_ENUM(NSUInteger, MatchLevel) {
    MatchDefault = 0,      //不区分大小写
    MatchNoPrefix,         //不区分大小写及前缀
    MatchNoSuffix,         //不区分大小写及后缀
    MatchNoPrefixAndSuffix,//不区分大小写及前后缀

    MatchCapNoPrefix = 11,      //区分大小写 不区分前缀
    MatchCapNoSuffix,           //区分大小写 不区分后缀
    MatchCapNoPrefixAndSuffix,  //区分大小写 不区分前后缀
};








@interface NSObject (Safe)

/* 将所有与model不匹配或nil null的值规范化或初始化 */
-(void)SafeModel;


/* 置空所有数据，再将其初始化 */
-(void)ClearModel;




/* 
 *  自动匹配model和view中属性名字 并给相同的元素直接赋值
 *  仅支持Label，button，textfield，textview
 */
-(void)MatchToModel:(id)model;

/*  模糊匹配 */
-(void)MatchToModel:(id)model Level:(MatchLevel)level;






@end
