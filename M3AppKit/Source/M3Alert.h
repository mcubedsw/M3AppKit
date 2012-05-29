/*****************************************************************
 M3Alert.h
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

/**
 BRIEF_HERE
 @since PROJECT_NAME VERSION_NAME or later
*/
@interface M3Alert : NSAlert 

/**
 BRIEF_HERE
 @param PARAM_NAME PARAM_DESCRIPTION
  @param PARAM_NAME PARAM_DESCRIPTION
 @since PROJECT_NAME VERSION_NAME or later
*/
- (void)beginSheetModalForWindow:(NSWindow *)window completionHandler:(void (^)(NSInteger result))aHandler;

@end
