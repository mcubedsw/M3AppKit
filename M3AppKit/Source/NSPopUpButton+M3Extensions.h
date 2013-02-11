/*****************************************************************
 NSPopUpButton+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 28/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 Convenience Methods on NSPopUpButton
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSPopUpButton (M3Extensions)

/**
 Adds the supplied menu item to the receiver
 @param aItem The menu item to add to the receiver
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_addMenuItem:(NSMenuItem *)aItem;

/**
 Convenience method for adding a new item and retrieving it.
 @param aTitle The title of the new menu item
 @return The newly created menu item
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSMenuItem *)m3_addItemWithTitle:(NSString *)aTitle;

/**
 Selects the first item in the popup whos represented object matches the supplied object
 @param aRepresentedObject The represented object to match against
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)m3_selectItemWithRepresentedObject:(id)aRepresentedObject;

@end
