//
//  ViewController.m
//  3DTouch
//
//  Created by WangXuesen on 15/11/19.
//  Copyright © 2015年 WangXuesen. All rights reserved.
//

#import "ViewController.h"
#import "XSCellData.h"
#import "XSCellDataFrame.h"
#import "XSTableViewCell.h"
#import "XSPeekViewController.h"
#import "XSPopViewController.h"
@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>
@property (nonatomic , strong) UITableView    *tbView;
@property (nonatomic , strong) NSMutableArray *dataSource;
@property (nonatomic , assign) BOOL            support3DTouch;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //检测当前是否支持3DTouch
    self.support3DTouch = [self support3DTouch];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupSubViewsAndParams];
}

#pragma mark - private method

- (BOOL)support3DTouch
{
    // 如果开启了3D touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        return YES;
    }
    return NO;
}


- (void)setupSubViewsAndParams {
    
    [self.navigationController setTitle:@"3DTouch"];
    
    
    _tbView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tbView.dataSource = self;
    _tbView.delegate = self;
    [self.view addSubview:_tbView];
    //模拟网络请求回json后的解析过程
    self.dataSource = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        NSDictionary * dic = @{
                               @"name" : [NSString stringWithFormat:@"王学森forCell_%d",i],
                               @"header" : @"icon.jpg"
                               };
        XSCellData * cellData = [[XSCellData alloc] init];
        cellData.cellDataDic = dic;
        XSCellDataFrame *cellFrame = [[XSCellDataFrame alloc] init];
        cellFrame.cellData = cellData;
        [self.dataSource addObject:cellFrame];
        
    }
    [_tbView reloadData];
    
}

#pragma mark - 当配置发生了变化，在应用运行中，从支持变成了不支持，回调用这个回调
- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection NS_AVAILABLE_IOS(8_0) {
    
    self.support3DTouch = [self support3DTouch];
}

#pragma mark - 3DTouch  UIViewControllerPreviewingDelegate
//此方法是轻按控件时，跳出peek的代理方法
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //防止重复加入
    if ([self.presentedViewController isKindOfClass:[XSPeekViewController class]])
    {
        return nil;
    }
    else
    {
        XSTableViewCell *cell = (XSTableViewCell *)previewingContext.sourceView;
        XSCellData * cellData = cell.dataFrame.cellData;
        XSPeekViewController *peekViewController = [[XSPeekViewController alloc] init];
        peekViewController.cellData = cellData;
        return peekViewController;
    }
}

//此方法是重按peek时，跳出pop的代理方法
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    XSTableViewCell *cell = (XSTableViewCell *)previewingContext.sourceView;
    XSCellData * cellData = cell.dataFrame.cellData;
    XSPopViewController *popViewController = [[XSPopViewController alloc] init];
    popViewController.cellData = cellData;
    //以prentViewController的形式展现
    [self showViewController:popViewController sender:self];
    
    //以push的形势展现
//    [self.navigationController pushViewController:popViewController animated:YES];
}


#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XSTableViewCell"];
    if (cell == nil) {
        cell = [XSTableViewCell cellWithTableView:tableView];
    }
    cell.dataFrame = self.dataSource[indexPath.row];
    //给cell注册代理，使其支持3DTouch手势
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XSCellDataFrame *frame = self.dataSource[indexPath.row];
    return frame.cellHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XSCellDataFrame *frame = self.dataSource[indexPath.row];
    XSPopViewController *popVC = [[XSPopViewController alloc] init];
    popVC.cellData = frame.cellData;
    [self.navigationController pushViewController:popVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
