/*****************************************************************
 NSTabView+M3ExtensionsTests.m
 M3AppKit
 
 Created by Martin Pilkington on 11/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSTabView+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSTabView_M3ExtensionsTests

- (void)test_returnsIndexOfSelectedTab {
	NSTabView *tabView = [NSTabView new];
	
	NSTabViewItem *item1 = [[NSTabViewItem alloc] initWithIdentifier:@"1"];
	NSTabViewItem *item2 = [[NSTabViewItem alloc] initWithIdentifier:@"2"];
	NSTabViewItem *item3 = [[NSTabViewItem alloc] initWithIdentifier:@"3"];
	
	[tabView addTabViewItem:item1];
	[tabView addTabViewItem:item2];
	[tabView addTabViewItem:item3];
	
	assertThatInteger(tabView.m3_indexOfSelectedTab, is(equalToInteger(0)));
	
	[tabView selectTabViewItemAtIndex:1];
	
	assertThatInteger(tabView.m3_indexOfSelectedTab, is(equalToInteger(1)));
}

@end
