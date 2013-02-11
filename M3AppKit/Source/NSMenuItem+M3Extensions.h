/*****************************************************************
 NSMenuItem+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 16/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 Convenience methods on NSMenuItem
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSMenuItem (M3Extensions)

/**
 An item identifier property for menu items, similar to identifiers on views.
 This property provides a better option for uniquely identifying constraints than tags.
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (copy) NSString *m3_itemIdentifier;

@end
