/*****************************************************************
 M3Alert.h
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>

@interface M3Alert : NSAlert 

- (void)beginSheetModalForWindow:(NSWindow *)window completionHandler:(void (^)(NSInteger result))aHandler;

@end
