/*****************************************************************
 M3NavigationView.h
 M3AppKit
 
 Created by Martin Pilkington on 18/11/2008.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

@protocol M3NavigationViewDelegate, M3NavigationViewController;

/**
 M3NavigationView provides similar functionality to UIKit's UINavigationController. Unlike UINavigationController, it is a view, not a view
 controller. It is also much simpler, providing the basic functionality for managing a stack of view controllers.
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3NavigationView : NSView

/**
 The view controller currently visible in the navigation view
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak, readonly) id currentViewController;

/**
 The navigation view's delegate
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (unsafe_unretained) IBOutlet id<M3NavigationViewDelegate> delegate;

/**
 Toggles whether the navigation bar, which contains the back button and title, should be visible
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign, nonatomic) BOOL showsNavigationBar;

/**
 Pushes a view controller onto the view stack. This makes it the new current view controller
 
 M3NavigationView holds strong references to view controllers pushed onto the stack
 @param aController The view controller to push onto the stack
 @param aAnimated YES if the new view controller should be animated on, NO if it should appear with no animation
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)pushViewController:(NSViewController *)aController animated:(BOOL)aAnimated;

/**
 Pops the current view controller off the view stack
 @param aAnimted YES if the current view controller should be animated off, NO if it should be removed with no animation
 @return The navigation controller that was popped off
 @since PROJECT_NAME VERSION_NAME or later
*/
- (id)popViewControllerAnimated:(BOOL)aAnimated;

/**
 A convenience method for pushing a view onto the stack
 
 This method creates a new blank view controller and sets its view to the supplied view. This is useful if you merely want to display a stack 
 of views and the controls for the navigation view are placed elsewhere.
 @param aView The view to push onto the stack
 @param aAnimated YES if the new view should be animated on, NO if it should appear with no animation
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)pushView:(NSView *)aView animated:(BOOL)aAnimated;

@end




/**
 The delegate protocol for M3NavigationView
 @since PROJECT_NAME VERSION_NAME or later
*/
@protocol M3NavigationViewDelegate <NSObject>

@optional;
/**
 Informs the delegate that a view controller was replaced.
 
 Sent to the delegate on push and pop calls on the navigation view
 @param aView The navigation view invoking the method
 @param aOldController The controller that was previously the current view controller
 @param aNewController The controller that is now the current view controller
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)navigationView:(M3NavigationView *)aView didReplaceViewController:(id)aOldController withViewController:(id)aNewController;

@end