//
//  MDCAppDelegate.h
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCMainViewController.h"
#import "MDCSideMenuViewController.h"
#import "MDCMenuViewController.h"

@interface MDCAppDelegate : UIResponder <UIApplicationDelegate, MDCSideMenuViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) MDCSideMenuViewController *sideMenuViewController;
@property (nonatomic, strong) MDCMenuViewController *menuViewController;
@property (nonatomic, strong) MDCMainViewController *mainViewController;

@end
