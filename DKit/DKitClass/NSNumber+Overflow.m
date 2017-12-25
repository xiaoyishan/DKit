//
//  NSNumber+Overflow.m
//  动画测试
//
//  Created by xiaSang on 2017/12/21.
//  Copyright © 2017年 xiaSang. All rights reserved.
//

#import "NSNumber+Overflow.h"

@implementation NSNumber (Overflow)

// 处理浮点溢出
-(NSString*)NumberToString{
    NSString *douleStr = [NSString stringWithFormat:@"%lf",[self doubleValue]];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:douleStr];
    return [decNumber stringValue];
}

@end
