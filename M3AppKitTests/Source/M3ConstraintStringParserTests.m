/*****************************************************************
 M3ConstraintStringParserTests.m
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringParserTests.h"
#import "M3ConstraintStringParser.h"
#import "NSLayoutConstraint+M3Extensions.h"
#import "M3TestContentView.h"

@implementation M3ConstraintStringParserTests {
	M3ConstraintStringParser *parser;
	NSDictionary *substitutionViews;
}

- (void)setUp {
	substitutionViews = @{
		@"self" : [NSView new],
		@"x" : [NSView new],
		@"y" : [NSView new],
		@"z" : [NSView new]
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

- (void)testSizeConstantConstraintWithRelation {
	NSArray *constraints = [parser constraintsFromString:@"$self.size >= (4, 3)"];
	
	NSView *selfView = substitutionViews[@"self"];
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint constraintWithItem:selfView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:4],
		[NSLayoutConstraint constraintWithItem:selfView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:3],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSuperConstantConstraint {
	NSArray *constraints = [parser constraintsFromString:@"$self.margin = (1, 2, 3, 4)"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeTop constant:1],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeLeading constant:2],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeBottom constant:3],
		[NSLayoutConstraint m3_superviewConstraintWithView:substitutionViews[@"self"] attribute:NSLayoutAttributeTrailing constant:4]
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testSuperConstantConstraintWithGaps {
	NSArray *constraints = [parser constraintsFromString:@"$self.margin = (1, -, 3, -)"];
	
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

- (void)test_setsMultiplierIfSpecifiedBeforeAttribute {
	NSArray *constraints = [parser constraintsFromString:@"$self.bottom = 2.5($x.top)"];
	
	NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeTop multiplier:2.5 constant:0];
	
	[self assertThatConstraints:constraints areEqualToConstraints:@[expectedConstraint]];
}

- (void)testMultipleAttributesAreEqualToSingleConstant {
	NSArray *constraints = [parser constraintsFromString:@"$self.size = 42"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_fixedWidthConstraintWithView:substitutionViews[@"self"] constant:42],
		[NSLayoutConstraint m3_fixedHeightConstraintWithView:substitutionViews[@"self"] constant:42]
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testAllKeyPath {
	NSArray *constraints = [parser constraintsFromString:@"$all.(left, right) = (0, 10)"];
	NSMutableDictionary *viewsMinusSelf = [substitutionViews mutableCopy];
	[viewsMinusSelf removeObjectForKey:@"self"];
	
	NSArray *views = viewsMinusSelf.allValues;
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_superviewConstraintWithView:views[0] attribute:NSLayoutAttributeLeft constant:0],
		[NSLayoutConstraint m3_superviewConstraintWithView:views[0] attribute:NSLayoutAttributeRight constant:10],
		[NSLayoutConstraint m3_superviewConstraintWithView:views[1] attribute:NSLayoutAttributeLeft constant:0],
		[NSLayoutConstraint m3_superviewConstraintWithView:views[1] attribute:NSLayoutAttributeRight constant:10],
		[NSLayoutConstraint m3_superviewConstraintWithView:views[2] attribute:NSLayoutAttributeLeft constant:0],
		[NSLayoutConstraint m3_superviewConstraintWithView:views[2] attribute:NSLayoutAttributeRight constant:10],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)testKeyValueCoding {
	M3TestContentView *testView = [M3TestContentView new];
	NSView *contentView = [NSView new];
	[testView setContentView:contentView];
	
	M3ConstraintStringParser *kvcParser = [[M3ConstraintStringParser alloc] initWithSubstitutionViews:@{ @"self" : testView }];
	
	NSArray *constraints = [kvcParser constraintsFromString:@"$self.contentView.width = 10"];
	
	NSArray *expectedConstraints = @[
		[NSLayoutConstraint m3_fixedWidthConstraintWithView:contentView constant:10],
	];
	
	[self assertThatConstraints:constraints areEqualToConstraints:expectedConstraints];
}

- (void)test_nonSecondItemRequiringAttributeWorksWithOtherView {
	NSArray *constraints = [parser constraintsFromString:@"$x.width = $y.width"];
	
	NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:substitutionViews[@"x"] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"y"] attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
	
	[self assertThatConstraints:constraints areEqualToConstraints:@[expectedConstraint]];
}

- (void)test_nonSecondItemRequiringAttributeWorksWithOtherViewAndConstant {
	NSArray *constraints = [parser constraintsFromString:@"$x.width = $y.width + 20"];
	
	NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:substitutionViews[@"x"] attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"y"] attribute:NSLayoutAttributeWidth multiplier:1 constant:20];
	
	[self assertThatConstraints:constraints areEqualToConstraints:@[expectedConstraint]];
}

- (void)test_setsCorrectPriority {
	NSArray *constraints = [parser constraintsFromString:@"$self.bottom =(@365) $x.top"];
	
	NSLayoutConstraint *expectedConstraint = [NSLayoutConstraint constraintWithItem:substitutionViews[@"self"] attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:substitutionViews[@"x"] attribute:NSLayoutAttributeTop multiplier:1 constant:0];
	[expectedConstraint setPriority:365];
	
	[self assertThatConstraints:constraints areEqualToConstraints:@[expectedConstraint]];
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





#pragma mark -
#pragma mark Testing Substitution View Utility 

- (void)testSubstitutionViewsWithDictionary {
	NSView *fooView = [NSView new];
	NSView *barView = [NSView new];
	NSView *bazView = [NSView new];
	NSView *selfView = [NSView new];
	NSDictionary *views = M3SubstitutionViewsWithCollection(@{
		@"foo" : fooView,
		@"bar" : barView,
		@"baz" : bazView,
	}, selfView);
	
	NSDictionary *expected = @{
		@"foo" : fooView,
		@"bar" : barView,
		@"baz" : bazView,
		@"self": selfView
	};
	
	assertThat(views, is(equalTo(expected)));
}

- (void)testSubstitutionViewsWithNilCollection {
	NSView *selfView = [NSView new];
	
	NSDictionary *views = M3SubstitutionViewsWithCollection(nil, selfView);
	NSDictionary *expected = @{	@"self": selfView };
	
	assertThat(views, is(equalTo(expected)));
}

- (void)testSubstitutionViewsWithArray {
	NSView *fooView = [NSView new];
	NSView *barView = [NSView new];
	NSView *bazView = [NSView new];
	NSView *selfView = [NSView new];
	NSDictionary *views = M3SubstitutionViewsWithCollection(@[
		fooView,
		barView,
		bazView,
	], selfView);
	
	NSDictionary *expected = @{
		@"0" : fooView,
		@"1" : barView,
		@"2" : bazView,
		@"self": selfView
	};
	
	assertThat(views, is(equalTo(expected)));
}

@end
