/*****************************************************************
 M3NavigationViewProtocol.h
 M3AppKit
 
 Created by Martin Pilkington on 21/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


@class M3NavigationView;

/**
 A set of methods for NSViewControllers that are used with M3NavigationView
 @since M3AppKit 1.0 and later
 */
@protocol M3NavigationViewController <NSObject>

@optional

/**
 A reference to the navigation view containing this object
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign) M3NavigationView *navigationView;

/**
 Informs the receiver that the navigation view will start animating its view
 @since M3AppKit 1.0 and later
 */
- (void)willStartAnimating;

/**
 Informs the receiver it is about to become the current view controller
 @since M3AppKit 1.0 and later
 */
- (void)activateView;

/**
 Informs the receiver that the navigation view finished animating its view
 @since M3AppKit 1.0 and later
 */
- (void)didFinishAnimating;

@end
