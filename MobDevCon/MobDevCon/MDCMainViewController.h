//
//  MDCMainViewController.h
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MDCMainViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) IBOutlet UIButton *makeCall;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end