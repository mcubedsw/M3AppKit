/*****************************************************************
 M3PreferencesSection.h
 M3AppKit
 
 Created by Martin Pilkington on 15/01/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 M3PreferencesSection is a protocol that should be implemented by all classes intending to be used as sections in an M3PreferencesWindow
 @since PROJECT_NAME VERSION_NAME or later
*/
@protocol M3PreferencesSection <NSObject>

/**
 The title of the section
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSString *)title;
/**
 The toolbar icon for the section
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSImage *)toolbarIcon;

/**
 The view for the section
 @since PROJECT_NAME VERSION_NAME or later
*/
- (NSView *)view;

@optional
/**
 Called by the preferences window on the section when it will be displayed
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)sectionWillDisplay;

@end


/*
 Author note: I know the above methods should really be read only properties, but Apple STILL has not updated AppKit to use properties so
 these need to be methods to shut the compiler up when using this with NSViewControllers and the like.
*/