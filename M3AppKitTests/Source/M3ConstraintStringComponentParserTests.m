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





#pragma mark -
#pragma mark Keypath

//*****//
- (void)testFindsSimpleKeyPathInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attribute"];
	
	assertThat(component.keyPath, is(equalTo(@"self")));
}

//*****//
- (void)testFindsComplexKeyPathInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.foobar.baz.attribute"];
	
	assertThat(component.keyPath, is(equalTo(@"self.foobar.baz")));
}





#pragma mark -
#pragma mark Attribute

//*****//
- (void)testFindsSimpleAttributeInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attribute"];
	
	assertThat(component.attributeList, is(equalTo(@[ @"attribute" ])));
}

//*****//
- (void)testFindsAttributeListInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.(attr1, attr2)"];
	
	assertThat(component.attributeList, is(equalTo(@[ @"attr1", @"attr2"])));
}

//*****//
- (void)testFindsSuperAttributeInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.super"];
	
	assertThat(component.attributeList, is(equalTo(@[ @"top", @"leading", @"bottom", @"trailing"])));
}

//*****//
- (void)testFindsSizeAttributeInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.size"];
	
	assertThat(component.attributeList, is(equalTo(@[ @"width", @"height"])));
}





#pragma mark -
#pragma mark Multiplier

//*****//
- (void)testFindsMultiplierInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attr * 5.2"];
	
	assertThat(component.keyPath, is(equalTo(@"self")));
	assertThat(component.attributeList, is(equalTo(@[ @"attr" ])));
	assertThatFloat(component.multiplier, is(equalToFloat(5.2)));
}





#pragma mark -
#pragma mark Constant

//*****//
- (void)testFindsConstantInStringWithKeyPath {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attr + 42"];
	
	assertThat(component.keyPath, is(equalTo(@"self")));
	assertThat(component.attributeList, is(equalTo(@[ @"attr" ])));
	assertThat(component.constantList, is(equalTo(@[ @42 ])));
}

//*****//
- (void)testFindsNegativeConstantInStringWithKeyPath {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attr - 42"];
	assertThat(component.keyPath, is(equalTo(@"self")));
	assertThat(component.attributeList, is(equalTo(@[ @"attr" ])));
	assertThat(component.constantList, is(equalTo(@[ @-42 ])));
}

//*****//
- (void)testFindsMultiplierAndConstantInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"$self.attr * 5.2 + 42"];
	
	assertThat(component.keyPath, is(equalTo(@"self")));
	assertThat(component.attributeList, is(equalTo(@[ @"attr" ])));
	assertThatFloat(component.multiplier, is(equalToFloat(5.2)));
	assertThat(component.constantList, is(equalTo(@[ @42 ])));
}

//*****//
- (void)testFindsConstantInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"-42"];
	
	assertThat(component.constantList, is(equalTo(@[ @-42 ])));
}

//*****//
- (void)testFindsMultipleConstantsInString {
	M3ConstraintStringComponent *component = [parser componentFromString:@"(42, 5, 17)"];
	
	assertThat(component.constantList, is(equalTo(@[ @42, @5, @17 ])));
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
