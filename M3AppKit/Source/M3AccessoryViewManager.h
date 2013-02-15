/*****************************************************************
 M3AccessoryViewManager.h
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3AccessoryViewManager : NSObject 

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSLayoutConstraint *accessoryViewConstraint;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSView *accessoryView;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (readonly, getter = isAccessoryViewVisible) BOOL accessoryViewVisible;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)showAccessoryViewAnimated:(BOOL)aAnimated;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)hideAccessoryViewAnimated:(BOOL)aAnimated;


- (IBAction)showAccessoryView:(id)aSender;
- (IBAction)hideAccessoryView:(id)aSender;

@end