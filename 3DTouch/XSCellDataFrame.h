//
//  XSCellDataFrame.h
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class XSCellData;
@interface XSCellDataFrame : NSObject
//cell 的数据模型
@property (nonatomic , strong) XSCellData * cellData;

//头像的rect
@property (nonatomic , assign) CGRect       headerRect;

//名字的rect
@property (nonatomic , assign) CGRect       nameRect;

//cell height
@property (nonatomic , assign) CGFloat      cellHeight;

@end
