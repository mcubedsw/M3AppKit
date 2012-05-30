/*****************************************************************
 M3PreferencesWindow.h
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>
#import <M3Foundation/M3Foundation.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3PreferencesWindow : NSWindow <NSToolbarDelegate>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (copy) NSArray *sections;

@end
