//
//  M3Alert.m
//  Lighthouse Keeper
//
//  Created by Martin Pilkington on 01/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import "M3Alert.h"

@implementation M3Alert {
	void (^completionHandler)(NSInteger);
}

- (void)beginSheetModalForWindow:(NSWindow *)window completionHandler:(void (^)(NSInteger result))aHandler {
	completionHandler = [aHandler copy];
	[self beginSheetModalForWindow:window modalDelegate:self didEndSelector:@selector(_alertDidEnd:returnCode:contextInfo:) contextInfo:NULL];
}

- (void)_alertDidEnd:(NSAlert *)aAlert returnCode:(NSInteger)aCode contextInfo:(void *)aInfo {
	completionHandler(aCode);
}

@end
