//
//  UserView.m
//  DKit
//
//  Created by Sundear on 2017/7/18.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "UserView.h"

@implementation UserView




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self LoadView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self LoadView];
    }
    return self;
}

-(void)LoadView{
    self.backgroundColor = [UIColor lightGrayColor];
    
    _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, 150, 50)];
    _NameLabel.backgroundColor = [UIColor whiteColor];
    _NameLabel.text = @"1";
    [self addSubview:_NameLabel];


    _age = [UIButton buttonWithType:UIButtonTypeSystem];
    _age.frame = CGRectMake(150, 0, 150, 50);
    _age.backgroundColor = [UIColor orangeColor];
    [self addSubview:_age];

    _Phone = [[UITextField alloc]initWithFrame:CGRectMake(0, 55, 300, 40)];
    _Phone.backgroundColor = [UIColor whiteColor];
    [self addSubview:_Phone];

    _Home = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, 300, 40)];
    _Home.backgroundColor = [UIColor whiteColor];
    [self addSubview:_Home];
}




@end
