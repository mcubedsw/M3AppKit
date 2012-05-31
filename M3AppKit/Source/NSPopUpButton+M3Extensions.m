/*****************************************************************
 NSPopUpButton+M3Extensions.m
 M3AppKit
 
 Created by Martin Pilkington on 28/07/2011.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSPopUpButton+M3Extensions.h"


@implementation NSPopUpButton (M3Extensions)

//*****//
- (void)m3_addMenuItem:(NSMenuItem *)aItem {
	[self.menu addItem:aItem];
}

//*****//
- (NSMenuItem *)m3_addItemWithTitle:(NSString *)aTitle {
	[self addItemWithTitle:aTitle];
	return self.lastItem;
}

//*****//
- (void)m3_selectItemWithRepresentedObject:(id)aRepresentedObject {
	NSInteger index = [self indexOfItemWithRepresentedObject:aRepresentedObject];
	[self selectItemAtIndex:index];
}

@end
