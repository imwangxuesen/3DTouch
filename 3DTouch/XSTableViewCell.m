//
//  XSTableViewCell.m
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import "XSTableViewCell.h"
#import "XSCellDataFrame.h"
#import "XSCellData.h"
@implementation XSTableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"XSTableViewCell";
    XSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[XSTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.headerImgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.headerImgView ];
        
        self.nameLabel     = [[UILabel alloc] init];
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}


- (void)setDataFrame:(XSCellDataFrame *)dataFrame {
    
    _dataFrame = dataFrame;
    
    self.headerImgView.image = [UIImage imageNamed:self.dataFrame.cellData.header];
    self.headerImgView.frame = self.dataFrame.headerRect;
    
    self.nameLabel.text = self.dataFrame.cellData.name;
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.frame = self.dataFrame.nameRect;
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
