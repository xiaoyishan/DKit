//
//  ViewController.m
//  DKit
//
//  Created by Sundear on 2017/4/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>


@interface ViewController ()
@property (copy ,nonatomic) NSString *str;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];




}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSString *str
    NSString * str=@"as";//[NSNull null];//@"<null>";
//    [_str setValue:@"a" forKey:@"key"];
//    DLog(@"-%@-",str);

    //    DString *s1=@"----";
    //    s1=nil;
    //    DLog(@"--%@--",s1);


//    NSDictionary *dic=@{@"key1":@""};


    int kk=0;
    kk=@"1345";


    user *yy =[user new];

    [yy setKey2:@[]];
    [yy setKey1:@"++++"];
    yy.key3=@"123";
//    yy.key4=[NSNull null];
//    yy.key5=@"123.4";
    yy.key6=NULL;
    yy.key7=NULL;
    yy.key8=NULL;
    yy.key9=NULL;




    [yy SafeModel];


//    NSLog(@"%@--:%d",yy.key1,kk);

    


}













@end
