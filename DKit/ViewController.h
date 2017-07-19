//
//  ViewController.h
//  DKit
//
//  Created by Sundear on 2017/4/20.
//  Copyright © 2017年 xiexin. All rights reserved.
//
#import "NSObject+Safe.h"
#import "UserView.h"
#import "UserModel.h"


#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    UserView *CustomView;
}

@property (weak, nonatomic) IBOutlet UserView *myView;


@end

