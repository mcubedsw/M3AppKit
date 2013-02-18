/*****************************************************************
 M3AccessoryViewManager.h
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 M3AccessoryViewManager is a class for managing the display of an accessory view. By hooking up the view and the constraint on the edge
 you wish the view to appear from, it allows you to simply tell the view to show or hide.
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3AccessoryViewManager : NSObject 

/**
 The constraint between the view and the edge of its superview you want it to appear from.
 For example, if you wanted the accessoryView to appear from the bottom of its superview, you'd set this to the constraint between its bottom
 edge and its superview's bottom edge
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSLayoutConstraint *accessoryViewConstraint;

/**
 The accessory view to manage
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSView *accessoryView;

/**
 Returns YES if the accessory view is currently visible, NO if it is not
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (readonly, getter = isAccessoryViewVisible) BOOL accessoryViewVisible;

/**
 Displays the accessory view
 @param aAnimated Whether the accessory view should animate in
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)showAccessoryViewAnimated:(BOOL)aAnimated;

/**
 Hides the accessory view
 @param aAnimated Whether the accessory view should animate out
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)hideAccessoryViewAnimated:(BOOL)aAnimated;

/**
 Action for showing the accessory view
 This simply calls -showAccessoryViewAnimated:, passing in YES. It is provided as a convenience method for connecting up objects in NIBs
 @param aSender The sender of the action
 @since PROJECT_NAME VERSION_NAME or later
*/
- (IBAction)showAccessoryView:(id)aSender;

/**
 Action for hiding the accessory view
 This simply calls -hideAccessoryViewAnimated:, passing in YES. It is provided as a convenience method for connecting up objects in NIBs
 @param aSender The sender of the action
 @since PROJECT_NAME VERSION_NAME or later
*/
- (IBAction)hideAccessoryView:(id)aSender;

@end