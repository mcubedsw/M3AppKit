//
//  M3ConstraintStringParserTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 24/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringParserTests.h"
#import "M3ConstraintStringParser.h"
#import "NSLayoutConstraint+M3Extensions.h"

@implementation M3ConstraintStringParserTests {
	M3ConstraintStringParser *parser;
	NSDictionary *substitutionViews;
}

- (void)setUp {
	substitutionViews = @{
		@"self" : [NSView new],
		@"x" : [NSView new]
	};
	parser = [[M3ConstraintStringParser alloc] initWithSubstitutionViews:substitutionViews];
}

- (void)testBasicConstraint {
	NSArray *constraints = [parser constraintsFromString:@"$self.width = 5"];
	
	NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint m3_fixedWidthConstraintWithView:substitutionViews[@"self"] constant:5];
	
	assertThatInteger(constraints.count, is(equalToInteger(1)));
	[self assertThatConstraint:constraints[0] isEqualToConstraint:expectedConstraint];
}

- (void)testSizeConstantConstraint {
	NSArray *constraints = [parser constraintsFromString:@"$self.size = (4, 3)"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_fixedWidthConstraintWithView:substitutionViews[@"self"] constant:4],
		[NSLayoutConstraint m3_fixedHeightConstraintWithView:substitutionViews[@"self"] constant:3]
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSuperConstantConstraint {
	NSArray *constraints = [parser constraintsFromString:@"$self.super = (1, 2, 3, 4)"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeTop constant:1],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeLeading constant:2],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeBottom constant:3],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeTrailing constant:4]
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSuperConstantConstraintWithGaps {
	NSArray *constraints = [parser constraintsFromString:@"$self.super = (1, -, 3, -)"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeTop constant:1],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeBottom constant:3],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSecondItemAttributeEqualToFirstItemAttribute {
	NSArray *constraints = [parser constraintsFromString:@"$self.top = $x.bottom"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSecondItemAttributeEqualToFirstItemAttributeWithConstantAndMultiplier {
	NSArray *constraints = [parser constraintsFromString:@"$self.top = $x.bottom * 2.5 + 3"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeBottom multiplier:2.5 constant:3],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSecondItemAttributesAreEqualToFirstItemAttributes {
	NSArray *constraints = [parser constraintsFromString:@"$self.(top, left) = $x.(bottom, right)"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeRight multiplier:1 constant:0],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSecondItemAttributesAreEqualToFirstItemAttributesWithConstantAndMultiplier {
	NSArray *constraints = [parser constraintsFromString:@"$self.(top, left) = $x.(bottom, right) * 2.5 + 3"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeBottom multiplier:2.5 constant:3],
		[NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeRight multiplier:2.5 constant:3],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testMultipleAttributesAreEqualToSingleConstant {
	NSArray *constraints = [parser constraintsFromString:@"$self.size = 42"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_fixedWidthConstraintWithView:substitutionViews[@"self"] constant:42],
		[NSLayoutConstraint m3_fixedHeightConstraintWithView:substitutionViews[@"self"] constant:42]
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)assertThatConstraint:(NSLayoutConstraint *)aFirstConstraint isEqualToConstraint:(NSLayoutConstraint *)aSecondConstraint {
	assertThat(aFirstConstraint.firstItem, is(equalTo(aSecondConstraint.firstItem)));
	assertThatInteger(aFirstConstraint.firstAttribute, is(equalToInteger(aSecondConstraint.firstAttribute)));
	assertThatInteger(aFirstConstraint.relation, is(equalToInteger(aSecondConstraint.relation)));
	assertThat(aFirstConstraint.secondItem, is(equalTo(aSecondConstraint.secondItem)));
	assertThatInteger(aFirstConstraint.secondAttribute, is(equalToInteger(aSecondConstraint.secondAttribute)));
	assertThatFloat(aFirstConstraint.multiplier, is(equalToFloat(aSecondConstraint.multiplier)));
	assertThatFloat(aFirstConstraint.constant, is(equalToFloat(aSecondConstraint.constant)));
	assertThatInteger(aFirstConstraint.priority, is(equalToInteger(aSecondConstraint.priority)));
}

- (void)assertThatConstraints:(NSArray *)aFirstArray areEqualToConstraints:(NSArray *)aSecondArray {
	[aFirstArray enumerateObjectsUsingBlock:^(NSLayoutConstraint *generated, NSUInteger idx, BOOL *stop) {
		NSLayoutConstraint *expected = aSecondArray[idx];
		[self assertThatConstraint:generated isEqualToConstraint:expected];
	}];
}

@end
