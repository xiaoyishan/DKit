//
//  SimpleCell.h
//  DKit
//
//  Created by Sundear on 2017/7/19.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *Address;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UITextField *SubTitle;
@property (weak, nonatomic) IBOutlet UITextView *Describe;
@property (weak, nonatomic) IBOutlet UIImageView *ImageUrl;




@end
