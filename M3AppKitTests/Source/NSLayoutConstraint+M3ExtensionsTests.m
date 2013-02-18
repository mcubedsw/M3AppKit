/*****************************************************************
 NSLayoutConstraint+M3ExtensionsTests.m
 M3AppKit
 
 Created by Martin Pilkington on 11/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "NSLayoutConstraint+M3ExtensionsTests.h"
#import <M3AppKit/M3AppKit.h>

@implementation NSLayoutConstraint_M3ExtensionsTests

- (void)test_fixedWidthConstraintHasCorrectViewsAttributeMultiplierAndConstant {
	NSView *view = [NSView new];
	NSLayoutConstraint *constraint = [NSLayoutConstraint m3_fixedWidthConstraintWithView:view constant:50.0];
	
	assertThatFloat(constraint.constant, is(equalToFloat(50.0)));
	assertThatFloat(constraint.multiplier, is(equalToFloat(1.0)));
	assertThat(constraint.firstItem, is(equalTo(view)));
	assertThat(constraint.secondItem, is(nilValue()));
	assertThatInteger(constraint.firstAttribute, is(equalToInteger(NSLayoutAttributeWidth)));
}

- (void)test_fixedHeightConstraintHasCorrectViewsAttributeMultiplierAndConstant {
	NSView *view = [NSView new];
	NSLayoutConstraint *constraint = [NSLayoutConstraint m3_fixedHeightConstraintWithView:view constant:60.0];
	
	assertThatFloat(constraint.constant, is(equalToFloat(60.0)));
	assertThatFloat(constraint.multiplier, is(equalToFloat(1.0)));
	assertThat(constraint.firstItem, is(equalTo(view)));
	assertThat(constraint.secondItem, is(nilValue()));
	assertThatInteger(constraint.firstAttribute, is(equalToInteger(NSLayoutAttributeHeight)));
}

- (void)test_equalWidthsConstraintHasCorrectViewsAttributeMultiplierAndConstant {
	NSView *view1 = [NSView new];
	NSView *view2 = [NSView new];
	NSLayoutConstraint *constraint = [NSLayoutConstraint m3_equalWidthsConstraintWithView:view1 andView:view2];
	
	assertThatFloat(constraint.constant, is(equalToFloat(0.0)));
	assertThatFloat(constraint.multiplier, is(equalToFloat(1.0)));
	assertThat(constraint.firstItem, is(equalTo(view1)));
	assertThat(constraint.secondItem, is(equalTo(view2)));
	assertThatInteger(constraint.firstAttribute, is(equalToInteger(NSLayoutAttributeWidth)));
	assertThatInteger(constraint.secondAttribute, is(equalToInteger(NSLayoutAttributeWidth)));
}

- (void)test_equalHeightsConstraintHasCorrectViewsAttributeMultiplierAndConstant {
	NSView *view1 = [NSView new];
	NSView *view2 = [NSView new];
	NSLayoutConstraint *constraint = [NSLayoutConstraint m3_equalHeightsConstraintWithView:view1 andView:view2];
	
	assertThatFloat(constraint.constant, is(equalToFloat(0.0)));
	assertThatFloat(constraint.multiplier, is(equalToFloat(1.0)));
	assertThat(constraint.firstItem, is(equalTo(view1)));
	assertThat(constraint.secondItem, is(equalTo(view2)));
	assertThatInteger(constraint.firstAttribute, is(equalToInteger(NSLayoutAttributeHeight)));
	assertThatInteger(constraint.secondAttribute, is(equalToInteger(NSLayoutAttributeHeight)));
}

- (void)test_superviewConstraintHasCorrectViewsAttributeMultiplierAndConstant {
	NSView *superview = [NSView new];
	NSView *view = [NSView new];
	[superview addSubview:view];
	
	NSLayoutConstraint *constraint = [NSLayoutConstraint m3_superviewConstraintWithView:view attribute:NSLayoutAttributeLeading constant:25.0];
	
	assertThatFloat(constraint.constant, is(equalToFloat(25.0)));
	assertThatFloat(constraint.multiplier, is(equalToFloat(1.0)));
	assertThat(constraint.firstItem, is(equalTo(view)));
	assertThat(constraint.secondItem, is(equalTo(superview)));
	assertThatInteger(constraint.firstAttribute, is(equalToInteger(NSLayoutAttributeLeading)));
	assertThatInteger(constraint.secondAttribute, is(equalToInteger(NSLayoutAttributeLeading)));
}



@end
