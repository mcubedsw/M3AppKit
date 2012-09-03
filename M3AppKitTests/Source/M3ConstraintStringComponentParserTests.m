//
//  M3ConstraintStringComponentParserTests.m
//  M3AppKit
//
//  Created by Martin Pilkington on 03/09/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringComponentParserTests.h"
#import "M3ConstraintStringComponentParser.h"
#import "M3ConstraintStringComponent.h"

@implementation M3ConstraintStringComponentParserTests {
	M3ConstraintStringComponentParser *parser;
}

- (void)setUp {
	[super setUp];
	parser = [M3ConstraintStringComponentParser new];
}

- (void)testFindsSimpleKeyPathInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.height"];
	
	assertThat(component.keyPath, is(equalTo(@"self")));
}

- (M3ConstraintStringComponent *)componentWithKeyPath:(NSString *)aKeyPath attributeList:(NSArray *)aAttributeList multiplier:(CGFloat)aMultiplier constantList:(NSArray *)aConstantList {
	M3ConstraintStringComponent *component = [M3ConstraintStringComponent new];
	[component setKeyPath:aKeyPath];
	[component setAttributeList:aAttributeList];
	[component setMultiplier:aMultiplier];
	[component setConstantList:aConstantList];
	return component;
}

@end
