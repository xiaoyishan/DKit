//
//  NSObject+MatchModel.m
//  DKit
//
//  Created by Ys on 2017/7/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "NSObject+MatchModel.h"

@implementation NSObject (MatchModel)

#pragma mark -- 匹配

//自定义前缀 各种形容词千奇百怪 如果你的参数名比较复杂奇葩建议用yymodel映射你的model
-(NSArray*)PrefixArr{
    return @[@"Pre",@"Prepare",@"Plan",@"Fitst",@"Second",@"End",@"Latest",@"Old",@"New"];
}

//自定义后缀 根据自身习惯增删 建议只保留4个统一的
-(NSArray*)SuffixArr{
    return @[@"L",@"Label",@"label",
             @"B",@"Btn",@"Button",@"btn",@"B",@"button",
             @"F",@"Field",@"field",@"TextField",@"textfield",@"textField",@"Textfield",@"TF",
             @"T",@"Text",@"TextView",@"Textview",@"textview",@"TV",
             @"IMG",@"Image",@"image",@"I",@"IV",@"Img",@"ImageView",@"Imageview",@"imageview",@"imageView"];
}





/*
 *  自动匹配model和view中属性名字 并给相同的元素直接赋值 仅支持Label，button，textfield，textview ,imageview
 */
-(void)MatchToModel:(id)model{
    
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
        
        id KeyValue = [self findTheValue:model isKey:KeyName];//寻找相同key的值
        
//        NSLog(@"匹配结果:   type:%@  key:%@  value:%@",KeyClass , KeyName ,KeyValue);
        
        [self SetFitKeyTpye:KeyClass Key:KeyName Value:KeyValue];//赋值
        
    }
    free(propertys);
}

/* 模糊匹配等级 */
-(void)MatchToModel:(id)model Level:(MatchLevel)level{
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
        
        
        id KeyValue = [self findTheValue:model isKey:KeyName];//寻找相同key的值
        //模糊搜素
        if ([[NSString stringWithFormat:@"%@",KeyValue] length]==0) {
            KeyValue = [self findTheValue:model isKey:KeyName Level:level];//寻找相同key的值
        }
        
//        NSLog(@"匹配结果:   type:%@  key:%@  value:%@",KeyClass , KeyName ,KeyValue);
        
        [self SetFitKeyTpye:KeyClass Key:KeyName Value:KeyValue];//赋值
        
        
        
    }
    free(propertys);
}

//赋值
-(void)SetFitKeyTpye:(NSString*)subType Key:(NSString*)subKey Value:(id)subValue{


    if ([subType isEqual:@"UIButton"]) {
        NSString *newValue = [NSString stringWithFormat:@"%@",subValue];
        if (newValue.length>0) {
            UIButton *button = (UIButton*)[self valueForKey:subKey];
            button.Dtext = subValue;
        }

    }
    if ([subType isEqual:@"UILabel"]||[subType isEqual:@"UITextField"]||[subType isEqual:@"UITextView"]) {

        UILabel *label = (UILabel*)[self valueForKey:subKey];
        label.Dtext = subValue;
    }

    if ([subType isEqual:@"UIImageView"]) {
        UIImageView *ImageView = (UIImageView*)[self valueForKey:subKey];

        //网络图片
        if ([subValue isKindOfClass:[NSString class]]) {
            if ([(NSString*)subValue length]>5 && [[(NSString*)subValue substringToIndex:4] isEqual:@"http"]) {
                [ImageView sd_setImageWithURL:subValue placeholderImage:ImageView.image];
            }
        }
        //image对象
        if ([subValue isKindOfClass:[UIImage class]]) {
            ImageView.image = (UIImage*)subValue;
        }
        //URL文件
        if ([subValue isKindOfClass:[NSURL class]]) {
            ImageView.image = [UIImage imageWithContentsOfFile:subValue];
        }
        //二进制文件
        if ([subValue isKindOfClass:[NSData class]]) {
            ImageView.image = [UIImage imageWithData:subValue];
        }
        //imageview容器
        if ([subValue isKindOfClass:[UIImageView class]]) {
            ImageView.image = [(UIImageView*)subValue image];
        }

    }
}



//算法
//完全匹配
-(id)findTheValue:(id)model isKey:(NSString*)keyName{
    
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([model class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        NSString *myKey =[NSString stringWithUTF8String:propertyName];
        
        if ([keyName isEqual:myKey]) { //匹配
            free(propertys);
            return [model valueForKey:(NSString *)myKey];
        }
    }
    free(propertys);
    return @"";
}

//模糊匹配
-(id)findTheValue:(id)model isKey:(NSString*)keyName Level:(MatchLevel)level{
    
    BOOL IsFit = false;
    
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([model class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        NSString *myKey =[NSString stringWithUTF8String:propertyName];
        
        //开始匹配
        switch (level) {
            case MatchDefault://不区分大小写
                IsFit = [self isLowerStrA:myKey With:keyName];
                break;
            case MatchNoPrefix://不区分大小写及前缀
                IsFit = [self isLowerStrA:myKey With:keyName];
                if(!IsFit)IsFit = [self isNoPrefixStrA:myKey.lowercaseString With:keyName.lowercaseString];
                break;
            case MatchNoSuffix://不区分大小写及后缀
                IsFit = [self isLowerStrA:myKey With:keyName];
                if(!IsFit)IsFit = [self isNoSuffixStrA:myKey.lowercaseString With:keyName.lowercaseString];
                break;
            case MatchNoPrefixAndSuffix://不区分大小写及前后缀
                IsFit = [self isLowerStrA:myKey With:keyName];
                if(!IsFit)IsFit = [self isNoPrefixNoSuffixStrA:myKey.lowercaseString With:keyName.lowercaseString];
                break;
                
                
                
            case MatchCapNoPrefix://区分大小写 不区分前缀
                IsFit = [self isNoPrefixStrA:myKey With:keyName];
                break;
            case MatchCapNoSuffix://区分大小写 不区分后缀
                IsFit = [self isNoSuffixStrA:myKey With:keyName];
                break;
            case MatchCapNoPrefixAndSuffix://区分大小写 不区分前后缀
                IsFit = [self isNoPrefixNoSuffixStrA:myKey With:keyName];
                break;
                
            default:
                break;
        }
        
        
        if (IsFit) { //匹配
            free(propertys);
            return [model valueForKey:(NSString *)myKey];
        }
    }
    free(propertys);
    return @"";
}





//比对 大小写
-(BOOL)isLowerStrA:(NSString*)StrA With:(NSString*)StrB{
    if ([[StrA lowercaseString] isEqual:[StrB lowercaseString]]) {
        return YES;
    }
    return NO;
}

//比对 前缀 hasPrefix
-(BOOL)isNoPrefixStrA:(NSString*)StrA With:(NSString*)StrB{
    for (NSString *Pre in [self PrefixArr]) {
//        if (StrB.length>Pre.length && [StrA isEqual:[StrB substringFromIndex:Pre.length]]) {
//            return YES;
//        }
        if (StrB.length>Pre.length && [StrA hasPrefix:StrB]) {
            return YES;
        }
    }
    return NO;
}

//比对 后缀 hasSuffix
-(BOOL)isNoSuffixStrA:(NSString*)StrA With:(NSString*)StrB{
    for (NSString *Suf in [self SuffixArr]) {
//        if (StrB.length>Suf.length && [StrA isEqual:[StrB substringToIndex:Suf.length]]) {
//            return YES;
//        }
        if (StrB.length>Suf.length && [StrA hasSuffix:StrB]) {
            return YES;
        }
    }
    return NO;
}

//比对 移除前后缀
-(BOOL)isNoPrefixNoSuffixStrA:(NSString*)StrA With:(NSString*)StrB{
    //先匹配前后一方独存的情况 后缀优先
    if ([self isNoSuffixStrA:StrA With:StrB]) return YES;
    if ([self isNoPrefixStrA:StrA With:StrB]) return YES;
    
    //最终寻找2方都存在的情况
    for (NSString *Suf in [self SuffixArr]) {
        for (NSString *Pre in [self PrefixArr]) {
            if (StrB.length>Pre.length+Suf.length &&
                [StrA isEqual:[[StrB substringFromIndex:Pre.length] substringToIndex:Suf.length]]) {
                return YES;
            }
        }
    }
    return NO;
}


@end
