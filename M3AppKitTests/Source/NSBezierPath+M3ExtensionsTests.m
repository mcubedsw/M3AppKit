//
//  NSBezierPath+M3ExtensionsTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 06/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSBezierPath+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSBezierPath_M3ExtensionsTests {
	NSBezierPath *basicPath;
}

- (void)setUp {
	basicPath = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(0, 0, 20, 20)];
}

- (void)test_bezierPathContainsRect {
	NSRect contentRect = NSMakeRect(5, 5, 10, 10);
	assertThatBool([basicPath m3_containsRect:contentRect], is(equalToBool(YES)));
}

- (void)test_bezierPathDoesNotFullyContainRect {
	NSRect contentRect = NSMakeRect(5, 5, 10, 15);
	assertThatBool([basicPath m3_containsRect:contentRect], is(equalToBool(NO)));
}

- (void)test_rectIsEntirelyOutSideBezierPath {
	NSRect contentRect = NSMakeRect(20, 20, 10, 10);
	assertThatBool([basicPath m3_containsRect:contentRect], is(equalToBool(NO)));
}

@end
