//
//  NSObject+Safe.h
//  DKit
//
//  Created by Sundear on 2017/4/27.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (Safe)

+(void)SafeModel:(NSObject*)Model;
-(void)SafeModel;
@end
