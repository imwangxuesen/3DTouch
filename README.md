# 3DTouch

## 先来个效果图

# 开始搞出些事情

## Step 1 : 3DTouch 设备支持检测：

1,我们需要检测当前的设备是否支持3DTouch
    在iOS9中有一个新的枚举


> typedef NS_ENUM(NSInteger, UIForceTouchCapability) {  
        UIForceTouchCapabilityUnknown        = 0,  
        UIForceTouchCapabilityUnavailable    = 1,  
        UIForceTouchCapabilityAvailable      = 2
> };

> UIForceTouchCapabilityUnknown     : 未知的支持属性  
> UIForceTouchCapabilityUnavailable : 不支持  
> UIForceTouchCapabilityAvailable   : 支持  

一般我们都在每个ViewController的生命周期中这样做：  

###定义一个标志支持的BOOL属性  
`
@property (nonatomic , assign) BOOL            support3DTouch;
`

###在生命周期函数中检测支持与否


> - (void)viewWillAppear:(BOOL)animated {  
>     [super viewWillAppear:animated];  
>     //检测当前是否支持3DTouch  
>     self.support3DTouch = [self support3DTouch];  
> }


###在生命周期外检测支持与否（因为有可能出了生命周期函数而发生了变化）

> - (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection NS_AVAILABLE_IOS(8_0) {     
>     self.support3DTouch = [self support3DTouch];  
> }  

###检测是否支持3DTouch的方法

> - (BOOL)support3DTouch  
> {  
>     // 如果开启了3D touch  
>     if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)  
>     {  
>         return YES;  
>     }  
>         return NO;  
>     }  
> }  

##  Step 1 : 配置快捷视图列表   

效果如图：  

![ShotItems](http://ww3.sinaimg.cn/bmiddle/006bdQ7qjw1ey6dppvx27j30p018g0wc.jpg)  
### 方法 1：  
    直接配置info.plist  
    你需要：  
    1，将工程中的info.plist拷贝一份到桌面－－> 右键 --> 打开方式 －－> 文本编辑  
    2，按照下边的键值粘贴复制即可   

`

        <key>UIApplicationShortcutItems</key>         

            <array>               

                <dict>        

                        <key>UIApplicationShortcutItemIconType</key>    

                        <string>UIApplicationShortcutIconTypePlay</string>     

                        <key>UIApplicationShortcutItemTitle</key>   

                        <string>Play</string>         

                        <key>UIApplicationShortcutItemType</key>  

                        <string>static</string>       

                        <key>UIApplicationShortcutItemUserInfo</key>       

                        <dict>        

                            <key>key1</key>   

                            <string>value1</string>      

                        </dict>       

                </dict>     

            </array>  

`

    3，保存修改，然后将工程中的info.plist替换成桌面上的info.plist即可  
    4，也可以通过可视化的界面添加键值对，如下图：  
![info.plist](http://ww1.sinaimg.cn/bmiddle/006bdQ7qjw1ey6e0s0iafj311q0m4n7q.jpg)  
  
### 方法 2:  
    使用代码在工程中加入items  
    在工程的 > AppDelegate.m   
>       - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions    {  

>           //代码创建快捷视图列表的方法，  
>           //创建快捷视图列表有两种方法，一种是这样用代码写，另一种是编辑info.plist文件中的UIApplicationShortcutItems   
>           //这里我们使用编辑info。plist 的方式创建  
>           //    [self create3DTouchShotItems];  
>   }


>       - (void)create3DTouchShotItems {  

>           //创建快捷item的icon UIApplicationShortcutItemIconFile 
> 
>           UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon1"];
>           UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon2"];
>           UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"icon3"];
> 
>           //创建快捷item的userinfo UIApplicationShortcutItemUserInfo
>           NSDictionary *info1 = @{@"url":@"url1"};
>           NSDictionary *info2 = @{@"url":@"url2"};
>           NSDictionary *info3 = @{@"url":@"url3"};
> 
>           //创建ShortcutItem
>           UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"XS_3DTocuh_1" localizedTitle:@"王学森" localizedSubtitle:@"中文名字" icon:icon1 userInfo:info1];
>           UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"XS_3DTocuh_2" localizedTitle:@"WangXuesen" localizedSubtitle:@"拼音名字" icon:icon2 userInfo:info2];
>           UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]initWithType:@"XS_3DTocuh_3" localizedTitle:@"Jsen" localizedSubtitle:@"Eg Name" icon:icon3 userInfo:info3];

>           NSArray *items = @[item1, item2, item3];
>           [UIApplication sharedApplication].shortcutItems = items;
>       }

##  Step 2 : 在工程中处理屏幕快捷视图的点击事件响应

在工程的 > AppDelegate.m 
>       - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

>           //代码创建快捷视图列表的方法，  
>           //创建快捷视图列表有两种方法，一种是这样用代码写，另一种是编辑info.plist文件中的UIApplicationShortcutItems  
>           //这里我们使用编辑info。plist 的方式创建  
>           //    [self create3DTouchShotItems];  

>           //获取在快捷视图列表点击的item，并对其点击作出反应，此处是是打印出userinfo中的数据  
>           UIApplicationShortcutItem *item = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];  
>           [self clickedWithShortcutItem:item];  


>           // Override point for customization after application launch.  
>           self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];  
>           self.window.backgroundColor = [UIColor whiteColor];  
>           _rootVC = [[ViewController alloc] init];  
>           UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_rootVC];  

>           self.window.rootViewController = nav;  
>           [self.window makeKeyAndVisible];  
>           return YES;  

>       }  

## Step 3 : 给列表视图中的cell注册 3DTouch 事件  

1，首先，遵守UIViewControllerPreviewingDelegate协议  
> @interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>  

2，在注册前完成Step 1  

3，注册: [self registerForPreviewingWithDelegate:self sourceView:cell];  

>       - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{  
>           XSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XSTableViewCell"];  
>           if (cell == nil) {  
>               cell = [XSTableViewCell cellWithTableView:tableView];  
>           }  
>           cell.dataFrame = self.dataSource[indexPath.row];  
>           //给cell注册代理，使其支持3DTouch手势  
>           if (self.support3DTouch) {  
>               [self registerForPreviewingWithDelegate:self sourceView:cell];  
>           }  

>           return cell;  

>       }  

## Step 4 : 完成UIViewControllerPreviewingDelegate 协议回调，实现Peek Pop  
### Peek 效果  
![peek]  

### Peek 实现代码：  

> //此方法是轻按控件时，跳出peek的代理方法
>       - (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location  
>       {  
>           //防止重复加入  
>           if ([self.presentedViewController isKindOfClass:[XSPeekViewController class]])  
>           {  
>               return nil;  
>           }  
>           else  
>           {  
>               XSTableViewCell *cell = (XSTableViewCell *)previewingContext.sourceView;  
>               XSCellData * cellData = cell.dataFrame.cellData;  
>               XSPeekViewController *peekViewController = [[XSPeekViewController alloc] init];  
>               peekViewController.cellData = cellData;  
>               return peekViewController;  
>           }  
>       }  

### Pop 代码  

> //此方法是重按peek时，跳入pop的代理方法  
>       - (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit  
>       {    
>               XSTableViewCell *cell = (XSTableViewCell *)previewingContext.sourceView;  
>               XSCellData * cellData = cell.dataFrame.cellData;  
>               XSPopViewController *popViewController = [[XSPopViewController alloc] init];  
>               popViewController.cellData = cellData;  
>               //以prentViewController的形式展现  
>               [self showViewController:popViewController sender:self];  

>               //以push的形势展现  
>               //    [self.navigationController pushViewController:popViewController animated:YES];  
>       }  

## Step 5 : 在Peek状态下向上滑动出现的按钮配置方法  
 在 > XSPeekViewController.m  
 完成 > - (NSArray<id<UIPreviewActionItem>> *)previewActionItems  回调方法  
`
> - (NSArray\<id\<UIPreviewActionItem>> *)previewActionItems  
> {  
> // 生成UIPreviewAction  
>     UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"事件 1" style:UIPreviewActionStyleDefault                 handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>        NSLog(@"Action 1 selected");  
>     }];  
>     UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"事件 2" style:UIPreviewActionStyleDestructive   handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>         NSLog(@"Action 2 selected");  
>     }];  
>     UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"事件 3" style:UIPreviewActionStyleSelected   handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>         NSLog(@"Action 3 selected");  
>     }];  
>     UIPreviewAction *tap1 = [UIPreviewAction actionWithTitle:@"按钮 1" style:UIPreviewActionStyleDefault   handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>         NSLog(@"tap 1 selected");  
>     }];  
>     UIPreviewAction *tap2 = [UIPreviewAction actionWithTitle:@"按钮 2" style:UIPreviewActionStyleDestructive   handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>         NSLog(@"tap 2 selected");  
>     }];  
>     UIPreviewAction *tap3 = [UIPreviewAction actionWithTitle:@"按钮 3" style:UIPreviewActionStyleSelected   handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {  
>         NSLog(@"tap 3 selected");  
>     }];  

>     NSArray *actions = @[action1, action2, action3];  
>     NSArray *taps = @[tap1, tap2, tap3];  
>     UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"一组事件"   style:UIPreviewActionStyleDefault actions:actions];  
>     UIPreviewActionGroup *group2 = [UIPreviewActionGroup actionGroupWithTitle:@"一组按钮"   style:UIPreviewActionStyleDefault actions:taps];  
>     NSArray *group = @[group1,group2];  

>     //当然你也可以反三个单独的action对象的数组，而不是group，具体效果，可以自己试一下  

>     return group;  
> }  
`
## Step 6 : 特别注意事项

> 1，Peek Pop view都是普通的UIViewController，完全是自己继承后创建的  
> 2，在个人学习的过程中有一个需求，如果Pop界面有对导航栏，或者工具栏进行隐藏或者显示的操作，在Pop的viewcontroller的生命周期中去操> > 作 , 是没有任何反应的，需要去Peek 的 viewcontroller 中操作（viewWillDisappear）     
> 3，欢迎各位giter issue ， 也可去我的新浪微博留言 ： @NoemaThinkerMagician   
     


