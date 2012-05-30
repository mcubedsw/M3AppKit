/*****************************************************************
 M3NavigationView.h
 M3AppKit
 
 Created by Martin Pilkington on 18/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>
#import <QuartzCore/CoreAnimation.h>
#import "M3NavigationViewProtocol.h"

@protocol M3NavigationViewDelegate;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3NavigationView : NSView

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak, readonly) NSViewController *currentViewController;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (unsafe_unretained) IBOutlet id <M3NavigationViewDelegate>delegate;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (nonatomic, assign) BOOL showsNavigationBar;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)pushViewController:(NSViewController<M3NavigationViewProtocol> *)controller animated:(BOOL)animated;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)popViewControllerAnimated:(BOOL)animated;


//Convenience method
/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated;

@end




/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@protocol M3NavigationViewDelegate <NSObject>

@optional;
/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)navigationView:(M3NavigationView *)aView didReplaceViewController:(id)aOldController withViewController:(id)aNewController;

@end