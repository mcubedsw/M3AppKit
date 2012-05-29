/*****************************************************************
 NSPopUpButton+M3Extensions.h
 M3AppKit
 
 Created by Martin Pilkington on 28/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import <Cocoa/Cocoa.h>


@interface NSPopUpButton (M3Extensions)

- (void)m3_addMenuItem:(NSMenuItem *)aItem;
- (NSMenuItem *)m3_addItemWithTitle:(NSString *)aTitle;
- (void)m3_selectItemWithRepresentedObject:(id)aRepresentedObject;

@end
