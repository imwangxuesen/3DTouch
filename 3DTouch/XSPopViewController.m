//
//  XSPopViewController.m
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import "XSPopViewController.h"
#import "XSCellData.h"
@interface XSPopViewController ()

@end

@implementation XSPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView * imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.cellData.header]];
    imgView.frame = CGRectMake(0,
                               0,
                               self.view.frame.size.width,
                               self.view.frame.size.width);
    [self.view addSubview:imgView];
    
    UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    imgView.frame.origin.y + imgView.frame.size.height,
                                                                    self.view.frame.size.width,
                                                                    40)];
    nameLabel.text = self.cellData.name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:nameLabel];
    
    UILabel * popLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                   nameLabel.frame.origin.y + nameLabel.frame.size.height,
                                                                   self.view.frame.size.width,
                                                                   40)];
    popLabel.text = @"这是PopView";
    popLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:popLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
