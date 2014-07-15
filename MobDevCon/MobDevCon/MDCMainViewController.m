//
//  MDCMainViewController.m
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import "MDCMainViewController.h"
#import "MDCSideMenuViewController.h"
#import "MDCMTLGeneric.h"
#import "MDCAppDelegate.h"
#import "MTLJSONAdapter.h"

static NSString * const BaseURLString = @"BASE URL";

@implementation MDCMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Mob Dev Con!";
    
    UIBarButtonItem *openItem = [[UIBarButtonItem alloc] initWithTitle:@"Open" style:UIBarButtonItemStylePlain target:self action:@selector(openButtonPressed)];
    self.navigationItem.leftBarButtonItem = openItem;
}

- (void)openButtonPressed
{
    [self.sideMenuViewController openMenuAnimated:YES completion:nil];
}


- (IBAction)makeCall:(id)sender
{
    //Make API Call
    NSString *connectionString = [NSString stringWithFormat:@"%@", BaseURLString];
    NSURL *url = [NSURL URLWithString:connectionString];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    //Update Fields
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error With API Call"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    [operation start];
}

@end
