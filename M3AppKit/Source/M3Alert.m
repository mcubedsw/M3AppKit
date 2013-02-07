/*****************************************************************
 M3Alert.m
 M3AppKit
 
 Created by Martin Pilkington on 01/08/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


#import "M3Alert.h"

@implementation M3Alert {
	void (^completionHandler)(NSInteger);
}


- (void)beginSheetModalForWindow:(NSWindow *)aWindow completionHandler:(void (^)(NSInteger result))aHandler {
	completionHandler = [aHandler copy];
	[self beginSheetModalForWindow:aWindow modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}


- (void)alertDidEnd:(NSAlert *)aAlert returnCode:(NSInteger)aCode contextInfo:(void *)aInfo {
	completionHandler(aCode);
}

@end
