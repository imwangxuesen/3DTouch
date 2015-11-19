//
//  XSCellData.m
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import "XSCellData.h"

@implementation XSCellData

- (void)setCellDataDic:(NSDictionary *)cellDataDic {
    _cellDataDic = cellDataDic ;
    
    self.name = cellDataDic[@"name"];
    self.header = cellDataDic[@"header"];
    
}


@end
