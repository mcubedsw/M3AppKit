/*****************************************************************
 NSTextField+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Foundation/Foundation.h>

/**
 Convenience methods on NSTextField
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface NSTextField (M3Extensions)

/**
 Property for converting a text field between a label and standard text field
 The definition used for a label is a text field with no border, background and not selectable
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (assign, getter=m3_isLabel) BOOL m3_label;

@end
