//
//  NSMenuItem+M3ExtensionsTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 11/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSMenuItem+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSMenuItem_M3ExtensionsTests

- (void)test_menuItemStoresItemIdentifier {
	NSMenuItem *item = [NSMenuItem new];
	
	assertThat(item.m3_itemIdentifier, is(nilValue()));
	
	[item setM3_itemIdentifier:@"foobar"];
	
	assertThat(item.m3_itemIdentifier, is(equalTo(@"foobar")));
}

@end
