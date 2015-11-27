//
//  XSPeekViewController.h
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XSCellData;

@protocol XSPeekViewControllerDelegate <NSObject>

- (void)pushToPopViewControllerWithCellData:(XSCellData *)cellData;

@end

@interface XSPeekViewController : UIViewController
@property (nonatomic , strong) XSCellData * cellData;
@property (nonatomic , weak) id<XSPeekViewControllerDelegate>delegate;
@end
