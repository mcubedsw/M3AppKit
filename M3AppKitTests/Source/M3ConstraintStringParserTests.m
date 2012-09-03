//
//  M3ConstraintStringParserTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 24/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringParserTests.h"
#import "M3ConstraintStringParser.h"

@implementation M3ConstraintStringParserTests {
	M3ConstraintStringParser *parser;
	NSDictionary *substitutionViews;
}

- (void)setUp {
	M3ConstraintStringParser *parser = [[M3ConstraintStringParser alloc] initWithSubstitutionViews:nil];
}

- (void)testBasicConstraint {
	
}

- (void)assertThatConstraint:(NSLayoutConstraint *)aFirstConstraint isEqualToConstraint:(NSLayoutConstraint *)aSecondConstraint {
	assertThat(aFirstConstraint.firstItem, is(equalTo(aSecondConstraint.firstItem)));
	assertThat(@(aFirstConstraint.firstAttribute), is(equalTo(@(aSecondConstraint.firstAttribute))));
	assertThat(@(aFirstConstraint.relation), is(equalTo(@(aSecondConstraint.relation))));
	assertThat(aFirstConstraint.secondItem, is(equalTo(aSecondConstraint.secondItem)));
	assertThat(@(aFirstConstraint.secondAttribute), is(equalTo(@(aSecondConstraint.secondAttribute))));
	assertThat(@(aFirstConstraint.multiplier), is(equalTo(@(aSecondConstraint.multiplier))));
	assertThat(@(aFirstConstraint.constant), is(equalTo(@(aSecondConstraint.constant))));
	assertThat(@(aFirstConstraint.priority), is(equalTo(@(aSecondConstraint.priority))));
}

@end
