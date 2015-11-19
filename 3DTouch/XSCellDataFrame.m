//
//  XSCellDataFrame.m
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import "XSCellDataFrame.h"

@implementation XSCellDataFrame


- (void)setCellData:(XSCellData *)cellData {
    
    _cellData = cellData ;
    
    //此处应该根据celldata 中的数据进行头像和名字的尺寸计算，为了写demo，此处不在模拟这个过程
    _headerRect = CGRectMake(10, 10, 60, 60);
    
    CGFloat nameX = CGRectGetMaxX(_headerRect);
    CGFloat nameW = 100;
    CGFloat nameH = 20;
    CGFloat nameY = _headerRect.origin.y;
    _nameRect   = CGRectMake(nameX, nameY, nameW, nameH);
    
    _cellHeight = 80;
}

@end
