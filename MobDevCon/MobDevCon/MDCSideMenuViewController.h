//
//  MDCSideMenuViewController.h
//  MobDevCon
//
//  Created by Michael Salkin on 7/13/14.
//  Copyright (c) 2014 MSalkin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import "MDCMainViewController.h"

@class MDCSideMenuViewController;

@protocol MDCSideMenuViewControllerDelegate <NSObject>
@optional
- (void)sideMenuViewControllerWillOpenMenu:(MDCSideMenuViewController *)sideMenuViewController;
- (void)sideMenuViewControllerDidOpenMenu:(MDCSideMenuViewController *)sideMenuViewController;
- (void)sideMenuViewControllerWillCloseMenu:(MDCSideMenuViewController *)sideMenuViewController;
- (void)sideMenuViewControllerDidCloseMenu:(MDCSideMenuViewController *)sideMenuViewController;
@end

@interface MDCSideMenuViewController : UIViewController

typedef NS_ENUM(NSInteger, MDCSideMenuAnimationType) {
    MDCSideMenuAnimationTypeSlideOver, //Default - new view controllers slide over the old view controller.
    MDCSideMenuAnimationTypeFadeIn //New View controllers fade in over the old view controller.
};

/** Apply to this delegate to get several side menu events */
@property (nonatomic, weak) id<MDCSideMenuViewControllerDelegate> delegate;

/** The animation type - will default to Slide Over. */
@property (nonatomic, assign) MDCSideMenuAnimationType animationType;

/** Time interval for opening and closing the side menu */
@property (nonatomic, assign) NSTimeInterval animationDuration;

/** Time interval for swapping main view controllers */
@property (nonatomic, assign) NSTimeInterval animationSwapDuration;

/** Is the menu currently open? */
@property (nonatomic, assign, getter = isOpen) BOOL open;

/** Offset to position the menu in open position */
@property (nonatomic, assign) UIOffset edgeOffset;

/** The scale for zooming the viewport. 0.0 to 1.0 */
@property (nonatomic, assign) CGFloat zoomScale;

/** The color of the shadow to display behind the scaled main view */
@property (nonatomic, strong) UIColor *shadowColor;

/** Left side menu view */
@property (nonatomic, strong) IBOutlet UIViewController *menuViewController;

/** Main View */
@property (nonatomic, strong) IBOutlet MDCMainViewController *mainViewController;

/** When the menu is opened, a transparent button is displayed over the main view. This property gives the opportunity to modify it's accessibility label. */
@property (nonatomic, copy) NSString *closeOverlayAccessibilityLabel;

/** When the menu is opened, a transparent button is displayed over the main view. This property gives the opportunity to modify it's accessibility hint. */
@property (nonatomic, copy) NSString *closeOverlayAccessibilityHint;

/** Initializer that sets up a menuViewController and a mainViewController
 @param menuViewController The view controller to display in the left view
 @param mainViewController The view controller to display in the right view
 @return MDCMenuViewController A view that manages a menu view and opening/closing animations
 */
- (id)initWithMenuViewController:(UIViewController *)menuViewController mainViewController:(UIViewController *)mainViewController;

@end

@interface MDCSideMenuViewController (MenuActions)

/** Open the left side menu; animated or not
 @param animated Is the menu open action animated
 */
- (void)openMenuAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/** Close the left side menu; animated or not
 @param animated Is the menu close action animated
 */
- (void)closeMenuAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/** Toggle the state of the left side menu
 @param animated Is the toggle action animated
 */
- (void)toggleMenuAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end

@interface MDCSideMenuViewController (MainViewActions)

- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated closeMenu:(BOOL)closeMenu;

@end

@interface UIViewController (MDCSideMenuViewController)

@property (nonatomic, weak) MDCSideMenuViewController *sideMenuViewController;

@end
