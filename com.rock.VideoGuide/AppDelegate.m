//
//  AppDelegate.m
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/13.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "AdvertViewController.h"

@interface AppDelegate ()

@property(strong,nonatomic) UITabBarController * tabVC;

@property(strong,nonatomic) FirstViewController * firstVC;
@property(strong,nonatomic) SecondViewController * secondVC;
@property(strong,nonatomic) ThirdViewController * thirdVC;
@property(strong,nonatomic) AdvertViewController * advertVC;

@property(strong,nonatomic) UINavigationController * firstNav;

@end

@implementation AppDelegate

-(AdvertViewController*)advertVC
{
    if( !_advertVC )
    {
        _advertVC = [AdvertViewController new];
        _advertVC.tabBarItem.title = @"setting";
    }
    
    return _advertVC;
}

-(FirstViewController*)firstVC
{
    if( !_firstVC )
    {
        _firstVC = [FirstViewController new];
        _firstVC.title = @"Newest";
    }
    
    return _firstVC;
}

-(UINavigationController*)firstNav
{
    if( !_firstNav )
    {
        _firstNav = [[UINavigationController alloc]initWithRootViewController:self.firstVC];
        _firstNav.tabBarItem.title = @"Newest";
        
    }
    return _firstNav;
}


-(SecondViewController*)secondVC
{
    if( !_secondVC )
    {
        _secondVC = [SecondViewController new];
        _secondVC.title = @"Hottest";
    }
    
    return _secondVC;
}

-(ThirdViewController*)thirdVC
{
    if( !_thirdVC )
    {
        _thirdVC = [ThirdViewController new];
        _thirdVC.tabBarItem.title = @"Setting";
    }
    
    return _thirdVC;
}

-(UITabBarController*)tabVC
{
    if( !_tabVC )
    {
        _tabVC = [UITabBarController new];
        _tabVC.viewControllers = @[self.firstVC,self.secondVC,self.advertVC];
    }
    
    return _tabVC;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:self.tabVC];
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyWindow];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
