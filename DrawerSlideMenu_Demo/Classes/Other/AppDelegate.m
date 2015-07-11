//
//  AppDelegate.m
//  CocoaPodsDemo
//
//  Created by JJetGu on 15-6-30.
//  Copyright (c) 2015年 Free. All rights reserved.
//

#import "AppDelegate.h"
#import "MSMenuViewController.h"
#import "MSDynamicsDrawerViewController.h"
#import "MSDynamicsDrawerStyler.h"
#import "MSLogoViewController.h"

@interface AppDelegate ()<MSDynamicsDrawerViewControllerDelegate>

/**
 *  窗口的背景颜色
 */
@property (nonatomic, strong) UIImageView *windowBackground;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.dynamicsDrawerViewController = [[MSDynamicsDrawerViewController alloc]init];
    self.dynamicsDrawerViewController.delegate = self;
    
    /**
     *  添加左右两边动画的类型
     */
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerScaleStyler styler], [MSDynamicsDrawerFadeStyler styler]] forDirection:MSDynamicsDrawerDirectionLeft];
    
    [self.dynamicsDrawerViewController addStylersFromArray:@[[MSDynamicsDrawerParallaxStyler styler]] forDirection:MSDynamicsDrawerDirectionRight];
    
    /**
     *  添加左边菜单页
     */
    MSMenuViewController *menuViewController = [MSMenuViewController new];
    menuViewController.dynamicsDrawerViewController = self.dynamicsDrawerViewController;
    [self.dynamicsDrawerViewController setDrawerViewController:menuViewController forDirection:MSDynamicsDrawerDirectionLeft];
    
    // 默认显示Stylers这个Controller
    [menuViewController transitionToViewController:MSPaneViewControllerTypeStylers];
    
    /**
     *  添加右边菜单页
     */
    MSLogoViewController *logoViewController = [MSLogoViewController new];
    [self.dynamicsDrawerViewController setDrawerViewController:logoViewController forDirection:MSDynamicsDrawerDirectionRight];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.dynamicsDrawerViewController;
    [self.window makeKeyAndVisible];
    
    [self.window addSubview:self.windowBackground];
    [self.window sendSubviewToBack:self.windowBackground];
    
    return YES;
}


#pragma mark - MSAppDelegate

- (UIImageView *)windowBackground
{
    if (!_windowBackground) {
        _windowBackground = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Window Background"]];
    }
    return _windowBackground;
}

////私有方法
///**
// *  @param paneState 拖动手势的状态描述
// */
//- (NSString *)descriptionForPaneState:(MSDynamicsDrawerPaneState)paneState
//{
//    switch (paneState) {
//        case MSDynamicsDrawerPaneStateOpen:
//            return @"MSDynamicsDrawerPaneStateOpen";
//        case MSDynamicsDrawerPaneStateClosed:
//            return @"MSDynamicsDrawerPaneStateClosed";
//        case MSDynamicsDrawerPaneStateOpenWide:
//            return @"MSDynamicsDrawerPaneStateOpenWide";
//        default:
//            return nil;
//    }
//}
//
///**
// *  @param paneState 划动的方向描述
// */
//- (NSString *)descriptionForDirection:(MSDynamicsDrawerDirection)direction
//{
//    switch (direction) {
//        case MSDynamicsDrawerDirectionTop:
//            return @"MSDynamicsDrawerDirectionTop";
//        case MSDynamicsDrawerDirectionLeft:
//            return @"MSDynamicsDrawerDirectionLeft";
//        case MSDynamicsDrawerDirectionBottom:
//            return @"MSDynamicsDrawerDirectionBottom";
//        case MSDynamicsDrawerDirectionRight:
//            return @"MSDynamicsDrawerDirectionRight";
//        default:
//            return nil;
//    }
//}
//
//#pragma mark - MSDynamicsDrawerViewControllerDelegate
//
//- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController mayUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
//{
//    NSLog(@"Drawer view controller may update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
//}
//
//- (void)dynamicsDrawerViewController:(MSDynamicsDrawerViewController *)drawerViewController didUpdateToPaneState:(MSDynamicsDrawerPaneState)paneState forDirection:(MSDynamicsDrawerDirection)direction
//{
//    NSLog(@"Drawer view controller did update to state `%@` for direction `%@`", [self descriptionForPaneState:paneState], [self descriptionForDirection:direction]);
//}

@end
