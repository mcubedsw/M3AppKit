/*****************************************************************
 M3PreferencesSection.h
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@protocol M3PreferencesSection <NSObject>

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSString *)title;
/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSImage *)image;
/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSView *)view;

@optional
/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)sectionWillDisplay;
@end
