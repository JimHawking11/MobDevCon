//
//  MDCMenuViewController.m
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import "MDCMenuViewController.h"
#import "MDCMainViewController.h"
#import "MDCSideMenuViewController.h"
#import "MDCAppDelegate.h"

@interface MDCMenuViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@end

@implementation MDCMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect imageViewRect = [[UIScreen mainScreen] bounds];
    imageViewRect.size.width += 589;
    self.backgroundImageView.frame = imageViewRect;
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.backgroundImageView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
