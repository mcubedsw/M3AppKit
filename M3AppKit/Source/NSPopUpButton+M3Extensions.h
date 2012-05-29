/*****************************************************************
 NSPopUpButton+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 28/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSPopUpButton (M3Extensions)

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_addMenuItem:(NSMenuItem *)aItem;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSMenuItem *)m3_addItemWithTitle:(NSString *)aTitle;

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
 @return RETURN_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_selectItemWithRepresentedObject:(id)aRepresentedObject;

@end
