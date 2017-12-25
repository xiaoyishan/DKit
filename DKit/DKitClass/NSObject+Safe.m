//
//  NSObject+Safe.m
//  DKit
//
//  Created by Sundear on 2017/4/27.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "NSObject+Safe.h"







@implementation NSObject (Safe)

#pragma mark -- 模型处理

-(void)ModelSafe{

    //属性个数
    unsigned int propertyCount = 0;
    //获取class的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {

        objc_property_t property = propertys[i];
        const char * propertyClass = property_getAttributes(property);
        NSString *KeyClass=[NSString stringWithUTF8String:propertyClass];
        if ([KeyClass componentsSeparatedByString:@"\""].count>1) {
            KeyClass=[KeyClass componentsSeparatedByString:@"\""][1];
        }else{
            KeyClass=[KeyClass componentsSeparatedByString:@","].firstObject;
        }

        const char * propertyName = property_getName(property);
        NSString *KeyName =[NSString stringWithUTF8String:propertyName];

        id KeyValue = [self valueForKey:(NSString *)KeyName];
        

        //类型同步
        [self ConsistentwithDefine:KeyClass :KeyName :KeyValue];
        //异常处理
        [self KillNilNuLL:KeyClass :KeyName :KeyValue];


    }
    free(propertys);

}




-(void)KillNilNuLL:(NSString*)KeyClass :(NSString*)KeyName :(id)KeyValue{
    //先规范nil，null
    if (KeyValue==nil || KeyValue==[NSNull null]) {

        if ([KeyClass isEqualToString:@"NSArray"]) {
            [self setValue:@[] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableArray"]) {
            [self setValue:@[].mutableCopy forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSSet"]) {
            [self setValue:[NSSet new] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableSet"]) {
            [self setValue:[NSMutableSet new] forKey:KeyName];
        }

        if ([KeyClass isEqualToString:@"NSString"]) {
            [self setValue:@"" forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableString"]) {
            [self setValue:[NSMutableString stringWithFormat:@""] forKey:KeyName];
        }


        if ([KeyClass isEqualToString:@"NSDictionary"]) {
            [self setValue:@{} forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableDictionary"]) {
            [self setValue:@{}.mutableCopy forKey:KeyName];
        }

        if ([KeyClass isEqualToString:@"NSDate"]) {
            [self setValue:[NSDate new] forKey:KeyName];
        }
    }

}







-(void)ConsistentwithDefine:(NSString*)KeyClass :(NSString*)KeyName :(id)KeyValue{

    //基础类型(强制定义类型)
    if ([[KeyClass substringToIndex:1] isEqualToString:@"T"] && ![KeyValue isKindOfClass:[NSNumber class]]) {

        if ([KeyClass isEqualToString:@"Ti"]) {
            [self setValue:@([KeyValue intValue]) forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"Td"] ) {
            [self setValue:@([KeyValue doubleValue]) forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"Tf"] ) {
            [self setValue:@([KeyValue floatValue]) forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"TQ"]||[KeyClass isEqualToString:@"Tq"]) {
            [self setValue:@([KeyValue integerValue]) forKey:KeyName];
        }
    }

    //NS对象(强制定义类型)
    if ([[KeyClass substringToIndex:2] isEqualToString:@"NS"]) {

        if ([KeyClass isEqualToString:@"NSArray"] && ![KeyValue isKindOfClass:[NSArray class]]) {
            [self setValue:[NSArray arrayWithArray:KeyValue] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableArray"] && ![KeyValue isKindOfClass:[NSMutableArray class]]) {
            [self setValue:[NSMutableArray arrayWithArray:KeyValue] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSSet"] && ![KeyValue isKindOfClass:[NSSet class]]) {
            [self setValue:[NSSet setWithArray:KeyValue] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableSet"] && ![KeyValue isKindOfClass:[NSMutableSet class]]) {
            [self setValue:[NSMutableSet setWithArray:KeyValue] forKey:KeyName];
        }

        if ([KeyClass isEqualToString:@"NSString"] && ![KeyValue isKindOfClass:[NSString class]]) {
            if([KeyValue isKindOfClass:[NSNumber class]]){
                KeyValue = [(NSNumber*)KeyValue NumberToString]; // 浮点溢出
                //NSLog(@"浮点溢出:Name:%@ Value:%@",KeyName,KeyValue);
                [self setValue:[NSString stringWithFormat:@"%@",KeyValue] forKey:KeyName];
            }else{
               [self setValue:[NSString stringWithFormat:@"%@",KeyValue] forKey:KeyName];
            }
        
        }
        if ([KeyClass isEqualToString:@"NSMutableString"] && ![KeyValue isKindOfClass:[NSMutableString class]]) {
            [self setValue:[NSMutableString stringWithFormat:@"%@",KeyValue] forKey:KeyName];
        }


        if ([KeyClass isEqualToString:@"NSDictionary"] && ![KeyValue isKindOfClass:[NSDictionary class]]) {
            [self setValue:[NSDictionary dictionaryWithDictionary:KeyValue] forKey:KeyName];
        }
        if ([KeyClass isEqualToString:@"NSMutableDictionary"] && ![KeyValue isKindOfClass:[NSMutableDictionary class]]) {
            [self setValue:[NSMutableDictionary dictionaryWithDictionary:KeyValue] forKey:KeyName];
        }

    }
}



#pragma mark -- 清理


-(void)ModelClear{

    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyClass = property_getAttributes(property);
        NSString *KeyClass=[NSString stringWithUTF8String:propertyClass];
        if ([KeyClass componentsSeparatedByString:@"\""].count>1) {
            KeyClass=[KeyClass componentsSeparatedByString:@"\""][1];
        }else{
            KeyClass=[KeyClass componentsSeparatedByString:@","].firstObject;
        }

        const char * propertyName = property_getName(property);
        NSString *KeyName =[NSString stringWithUTF8String:propertyName];

        id KeyValue = [self valueForKey:(NSString *)KeyName];

        [self setValue:nil forKey:KeyName];

        //异常处理
        [self KillNilNuLL:KeyClass :KeyName :KeyValue];
        //类型同步
        [self ConsistentwithDefine:KeyClass :KeyName :KeyValue];
    }
    free(propertys);
}









@end
