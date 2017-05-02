//
//  NSObject+Safe.m
//  DKit
//
//  Created by Sundear on 2017/4/27.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "NSObject+Safe.h"

@implementation NSObject (Safe)




+(void)SafeModel:(NSObject*)Model{
    [Model setValue:@"----" forKey:@"key1"];
}
-(void)SafeModel{


    ///存储属性的个数
    unsigned int propertyCount = 0;
    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);

    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];

        const char * propertyClass = property_getAttributes(property);
        NSString *KeyClass=[NSString stringWithUTF8String:propertyClass];
        if ([KeyClass componentsSeparatedByString:@"\""].count>1) {
            KeyClass=[KeyClass componentsSeparatedByString:@"\""][1];
        }else{
            KeyClass=[KeyClass componentsSeparatedByString:@","].firstObject;
//            KeyClass=[KeyClass substringToIndex:1];
        }


        const char * propertyName = property_getName(property);
        NSString *KeyName =[NSString stringWithUTF8String:propertyName];

        id KeyValue = [self valueForKey:(NSString *)KeyName];
        NSLog(@"%@",[KeyValue class]);



        //基础类型
        if ([[KeyClass substringToIndex:1] isEqualToString:@"T"] && ![KeyValue isKindOfClass:[NSNumber class]]) {

            if ([KeyClass isEqualToString:@"Ti"]) {
                [self setValue:@([KeyValue intValue]) forKey:KeyName];
            }
            if ([KeyClass isEqualToString:@"Ti"] ) {
                [self setValue:@([KeyValue intValue]) forKey:KeyName];
            }
            if ([KeyClass isEqualToString:@"Tf"] ) {
                [self setValue:@([KeyValue floatValue]) forKey:KeyName];
            }
            if ([KeyClass isEqualToString:@"TQ"]||[KeyClass isEqualToString:@"Tq"]) {
                [self setValue:@([KeyValue integerValue]) forKey:KeyName];
            }
        }
        


        //NS对象
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

//            if ([KeyClass isEqualToString:@"NSObject"]) {
//                [self setValue:[NSObject new] forKey:KeyName];
//            }


        }




    }



}



@end
