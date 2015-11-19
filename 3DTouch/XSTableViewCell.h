//
//  XSTableViewCell.h
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSCellDataFrame;
@interface XSTableViewCell : UITableViewCell

@property (nonatomic , strong) UIImageView      * headerImgView;
@property (nonatomic , strong) UILabel          * nameLabel;
@property (nonatomic , strong) XSCellDataFrame  * dataFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
