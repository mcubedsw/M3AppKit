/*****************************************************************
 M3Alert.h
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

/**
 Adds block support for alerts
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3Alert : NSAlert 

/**
 Runs the receiver modally as an alert sheet on the supplied window
 @param aWindow The window to display the sheet on
 @param aHandler The block to be called when the sheet is dismissed
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)beginSheetModalForWindow:(NSWindow *)aWindow completionHandler:(void (^)(NSInteger result))aHandler;

@end
