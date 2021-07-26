//
//  AppDelegate.m
//  LanSongEditor_DEMO
//
//  Created by mac on 2018/11/30.
//  Copyright © 2018 mac. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"


#import <mach/mach.h>

#import <LanSongEditorFramework/LanSongEditor.h>// 包含LanSongSDK所有的库头文件
//测试

 @interface AppDelegate ()


@property (assign, nonatomic) UIBackgroundTaskIdentifier backIden;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 工程初始化配置
    [self appInitSetting];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden = YES;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    /*
     初始化SDK
     */
    if ([LanSongEditor initSDK:nil] == NO) {
    }else{
        //[self showSDKInfo];
    }
    
    /*
     删除sdk中所有的临时文件.
     */
    [LSOFileUtil deleteAllSDKFiles];
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}
/**
 当APP后台运行的时候,做处理.
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self beginBackGroundTask];
}
/**
 进入前台的处理.
 */
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self endBackGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    return YES;
}

#pragma mark- 前后台处理
//开始后台运行的一些任务;
-(void)beginBackGroundTask
{
    NSLog(@"begin  backGround task...");
    
    self.backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        //在时间到之前会进入这个block
        [self endBackGround];
    }];
}
//注销后台
-(void)endBackGround
{
    NSLog(@"endBackGround called.");
    [[UIApplication sharedApplication] endBackgroundTask:self.backIden];
    self.backIden = UIBackgroundTaskInvalid;
}

#pragma mark- 辅助
- (void)showSDKInfo
{
//    NSString *text1=[NSString stringWithFormat:@"当前版本:%@, 到期时间是:%d 年 %d 月之前",[LanSongEditor getVersion],
//                     [LanSongEditor getLimitedYear],[LanSongEditor getLimitedMonth]];
////    [iUtil showDialog:text1];
//
//    NSString *text2=[NSString stringWithFormat:@"我们SDK不包括UI界面, 本演示的所有界面都是公开代码, 不属于SDK的一部分."];
//    [iUtil showDialog:text2];  //显示对话框.
}

#pragma mark- initSetting
- (void)appInitSetting {
    
}

@end
