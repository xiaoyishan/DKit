//
//  ViewController.m
//  DKit
//
//  Created by Sundear on 2017/4/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"
#import <YYModel.h>


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CustomView = [[UserView alloc]initWithFrame:CGRectMake(15, 120, 300, 160)];
    [self.view addSubview:CustomView];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];


    
    NSString* json = @"{\"number\":66.51}";
    NSData* data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* numdic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    NSDictionary *dic = @{@"key1" : @"32",
                          @"key2" : @"234.1",
                          @"key3" : @"213.2",
                          @"key4" : @"-392",
                          @"key5" : @"-23",
                          @"key6" : @"12",
                          @"key7" : numdic[@"number"]
                          };

    UserModel *model = [UserModel yy_modelWithDictionary:dic];
    model.key7 = numdic[@"number"];
    [model ModelSafe];
    NSLog(@"%@" , [model yy_modelDescription]);
    
    CustomView.NameLabel.Dtext = numdic[@"number"];

}


- (IBAction)MatchView:(id)sender {
    UserModel *model = [[UserModel alloc]init];
    model.Name = @"MR.xie";
    model.Age = 25;
    model.Phone = 15355555555;
    model.Home = @"WdEa74KDd92kdoriG82kkkH..ds copy";
    //[CustomView MatchToModel:model];//完全匹配


    [CustomView MatchToModel:model Level:0];//不区分大小写
    //[CustomView MatchToModel:model Level:MatchCapNoPrefixAndSuffix];//区分大小写 不区分前后缀
}



@end
