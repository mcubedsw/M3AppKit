//
//  NSPopUpButton+M3Extensions.h
//  M3AppKit
//
//  Created by Martin Pilkington on 28/07/2011.
//  Copyright 2011 M Cubed Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSPopUpButton (M3Extensions)

- (void)m3_addMenuItem:(NSMenuItem *)aItem;
- (NSMenuItem *)m3_addItemWithTitle:(NSString *)aTitle;
- (void)m3_selectItemWithRepresentedObject:(id)aRepresentedObject;

@end
