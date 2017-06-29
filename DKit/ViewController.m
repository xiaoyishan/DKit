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


    user *yy =[user new];

    [yy setKey2:@[]];
    [yy setKey1:@"++++"];
    yy.key3=@"123";
    yy.key6=NULL;
    yy.key7=nil;
    yy.key8=NULL;
    yy.key9=NULL;




    [yy SafeModel];


    NSLog(@"%@",yy.description);

    


}













@end
