//
//  UIKit+Dtext.h
//  NullTest
//
//  Created by Ys on 2017/4/20.
//  Copyright © 2017年 Ys. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Dtext)
-(void)setDtext:(NSString *)Dtext;
@end

@interface UITextField (Dtext)
-(void)setDtext:(NSString *)Dtext;
@end

@interface UITextView (Dtext)
-(void)setDtext:(NSString *)Dtext;
@end


@interface UIButton (Dtext)
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
