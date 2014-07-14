//
//  MDCAppDelegate.m
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import "MDCAppDelegate.h"
#import "MDCMenuViewController.h"
#import "MDCMainViewController.h"
#import "MDCSideMenuViewController.h"


@interface MDCAppDelegate ()

@end

@implementation MDCAppDelegate

//Initalize Slide Control
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.menuViewController = [[MDCMenuViewController alloc] initWithNibName:@"MDCMenuViewController" bundle:nil];
    
    self.mainViewController = [[MDCMainViewController alloc] initWithNibName:@"MDCMainViewController" bundle:nil];
    
    self.sideMenuViewController = [[MDCSideMenuViewController alloc] initWithMenuViewController:self.menuViewController mainViewController:[[UINavigationController alloc] initWithRootViewController:self.mainViewController]];
    self.sideMenuViewController.shadowColor = [UIColor blackColor];
    self.sideMenuViewController.edgeOffset = (UIOffset) { .horizontal = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 18.0f : 0.0f };
    self.sideMenuViewController.zoomScale = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ? 0.93f : 0.85f;
    self.sideMenuViewController.delegate = self;
    self.window.rootViewController = self.sideMenuViewController;
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - MDCSideMenuViewControllerDelegate

- (UIStatusBarStyle)sideMenuViewController:(MDCSideMenuViewController *)sideMenuViewController statusBarStyleForViewController:(UIViewController *)viewController
{
    if (viewController == self.menuViewController) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)sideMenuViewControllerWillOpenMenu:(MDCSideMenuViewController *)sender {
    NSLog(@"willOpenMenu");
}

- (void)sideMenuViewControllerDidOpenMenu:(MDCSideMenuViewController *)sender {
    NSLog(@"didOpenMenu");
}

- (void)sideMenuViewControllerWillCloseMenu:(MDCSideMenuViewController *)sender {
    NSLog(@"willCloseMenu");
}

- (void)sideMenuViewControllerDidCloseMenu:(MDCSideMenuViewController *)sender {
	NSLog(@"didCloseMenu");
}

@end
