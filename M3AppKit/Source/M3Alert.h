//
//  M3Alert.h
//  Lighthouse Keeper
//
//  Created by Martin Pilkington on 01/08/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface M3Alert : NSAlert 

- (void)beginSheetModalForWindow:(NSWindow *)window completionHandler:(void (^)(NSInteger result))aHandler;

@end
