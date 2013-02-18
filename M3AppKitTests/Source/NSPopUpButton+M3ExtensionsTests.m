/*****************************************************************
 NSPopUpButton+M3ExtensionsTests.m
 M3AppKit
 
 Created by Martin Pilkington on 11/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSPopUpButton+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSPopUpButton_M3ExtensionsTests {
	NSPopUpButton *popUpButton;
}

- (void)setUp {
	[super setUp];
	
	popUpButton = [NSPopUpButton new];
	
	NSMenu *menu = popUpButton.menu;
	[menu addItemWithTitle:@"foobar" action:NULL keyEquivalent:@""];
	[menu.itemArray.lastObject setRepresentedObject:@1];
	[menu addItemWithTitle:@"baz" action:NULL keyEquivalent:@""];
	[menu.itemArray.lastObject setRepresentedObject:@5];
}

- (void)test_addedMenuItemIsAppendedToEndOfPopUp {
	NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"possum" action:NULL keyEquivalent:@""];
	[popUpButton m3_addMenuItem:item];
	assertThat(popUpButton.menu.itemArray.lastObject, is(equalTo(item)));
}

- (void)test_menuItemIsCreatedWithTitleAndAppendedToEndOfPopUp {
	NSMenuItem *item = [popUpButton m3_addItemWithTitle:@"possumbar"];
	assertThat(item.title, is(equalTo(@"possumbar")));
	assertThat(popUpButton.menu.itemArray, hasCountOf(3));
}

- (void)test_itemWithRepresentedObjectIsSelected {
	assertThatInteger(popUpButton.indexOfSelectedItem, is(equalToInteger(0)));
	
	[popUpButton m3_selectItemWithRepresentedObject:@5];
	
	assertThatInteger(popUpButton.indexOfSelectedItem, is(equalToInteger(1)));
}


@end
