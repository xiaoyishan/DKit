//
//  ViewController.m
//  DKit
//
//  Created by Sundear on 2017/4/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UserModel *model = [[UserModel alloc]init];
    model.Name = @"MR.xie";
    model.Age = 25;
    model.Phone = 15355555555;
    model.Home = @"WdEa74KDd92kdoriG82kkkH..ds copy";

    CustomView = [[UserView alloc]initWithFrame:CGRectMake(0, 120, 320, 160)];
    [self.view addSubview:CustomView];

    //[CustomView MatchToModel:model];//完全匹配

    
    [CustomView MatchToModel:model Level:0];//不区分大小写
    //[CustomView MatchToModel:model Level:MatchCapNoPrefixAndSuffix];//区分大小写 不区分前后缀


}



@end
