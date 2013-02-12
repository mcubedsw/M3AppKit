//
//  NSView+M3ExtensionsTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 12/02/2013.
//  Copyright (c) 2013 M Cubed Software. All rights reserved.
//

#import "NSView+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSView_M3ExtensionsTests {
	NSView *rootView;
	NSView *subview1;
	NSView *subview2;
	NSView *subview3;
	NSView *deepSubview;
}

- (void)setUp {
	[super setUp];
	
	rootView = [NSView new];
	
	subview1 = [NSView new];
	subview2 = [NSView new];
	subview3 = [NSView new];
	deepSubview = [NSView new];
	
	[rootView addSubview:subview1];
	[rootView addSubview:subview2];
	[rootView addSubview:subview3];
	[subview2 addSubview:deepSubview];
}





#pragma mark -
#pragma mark -m3_containsView:

- (void)test_returnsYESIfViewContainsView {
	assertThatBool([rootView m3_containsView:subview1], is(equalToBool(YES)));
}

- (void)test_returnsYESIfViewContainsDeepSubview {
	assertThatBool([rootView m3_containsView:deepSubview], is(equalToBool(YES)));
}

- (void)test_returnsNOIfViewViewDoesNotContainView {
	assertThatBool([rootView m3_containsView:[NSView new]], is(equalToBool(NO)));
}

- (void)test_returnsNOIfViewIsSameAsReceiver {
	assertThatBool([rootView m3_containsView:rootView], is(equalToBool(NO)));
}





#pragma mark -
#pragma mark -m3_viewName

- (void)test_returnsClassNameIfViewDoesntRespondToStringValueOrTitle {
	NSView *view = [NSView new];
	assertThat(view.m3_viewName, is(equalTo(@"NSView")));
}

- (void)test_returnsClassNameAndTitleIfViewRespondsToTitle {
	NSButton *button = [NSButton new];
	[button setTitle:@"foobar"];
	assertThat(button.m3_viewName, is(equalTo(@"NSButton (foobar)")));
}

- (void)test_returnsClassNameAndStringValueIfViewRespondsToStringValue {
	NSTextField *textField = [NSTextField new];
	[textField setStringValue:@"possum"];
	assertThat(textField.m3_viewName, is(equalTo(@"NSTextField (possum)")));
}





#pragma mark -
#pragma mark -m3_removeAllSubviews

- (void)test_viewHasNoSubviewsAfterTheyreAllRemoved {
	[rootView m3_removeAllSubviews];
	assertThat(rootView.subviews, hasCountOf(0));
}





#pragma mark -
#pragma mark Sorting Views

- (void)test_viewIsAtEndOfSubviewArrayAfterBeingBroughtToFront {
	[subview2 m3_bringViewToFront];
	assertThat(rootView.subviews.lastObject, is(equalTo(subview2)));
}

- (void)test_viewIsAtFrontOfSubviewArrayAfterBeingSentToBack {
	[subview2 m3_sendViewToBack];
	assertThat(rootView.subviews[0], is(equalTo(subview2)));
}

- (void)test_callsComparatorWhenSorting {
	__block BOOL comparatorCalled = NO;
	[rootView m3_sortSubviewsUsingBlock:^NSComparisonResult(id obj1, id obj2) {
		comparatorCalled = YES;
		return NSOrderedSame;
	}];
	assertThatBool(comparatorCalled, is(equalToBool(YES)));
}




@end
