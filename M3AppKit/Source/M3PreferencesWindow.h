/*****************************************************************
 M3PreferencesWindow.h
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 M3PreferencesWindow encapsulates the functionality found in the preferences windows of most Mac applications. It allows you to define
 each section in your preferences as a collection of view controllers. M3PreferencesWindow will then handle managing the toolbar, window
 state and transitioning between sections
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3PreferencesWindow : NSWindow <NSToolbarDelegate>

/**
 The preferences sections to display in the preferences window
 
 All objects in the array must conform to the M3PreferencesSection protocol.
 @since PROJECT_NAME VERSION_NAME or later
*/
@property (copy) NSArray *sections;

@end
