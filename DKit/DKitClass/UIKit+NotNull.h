//
//  UIKit+NotNull.h
//  NullTest
//
//  Created by Ys on 2017/4/20.
//  Copyright © 2017年 Ys. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (NotNull)
-(void)setDtext:(NSString *)Dtext;
@end

@interface UITextField (NotNull)
-(void)setDtext:(NSString *)Dtext;
@end

@interface UITextView (NotNull)
-(void)setDtext:(NSString *)Dtext;
@end


@interface UIButton (NotNull)
-(void)setDtext:(NSString *)Dtext;
@end




/*
 @"NIL" :
 @"Nil" :
 @"nil" :
 @"NULL" :
 @"Null" :
 @"null" :
 @"(NULL)"
 @"(Null)"
 @"(null)"
 @"<NULL>"
 @"<Null>"
 @"<null>"
 */
