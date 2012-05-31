/*****************************************************************
 M3DualViewController.h
 M3AppKit
 
 Created by Martin Pilkington on 05/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3DualViewController : NSObject 

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSLayoutConstraint *secondaryViewConstraint;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (weak) IBOutlet NSView *secondaryView;

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (readonly, getter = isSecondaryViewVisible) BOOL secondaryViewVisible;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)showSecondaryViewAnimated:(BOOL)aAnimated;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)hideSecondaryViewAnimated:(BOOL)aAnimated;

@end