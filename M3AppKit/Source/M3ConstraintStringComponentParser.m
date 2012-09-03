//
//  M3ConstraintStringComponentParser.m
//  M3AppKit
//
//  Created by Martin Pilkington on 03/09/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringComponentParser.h"
#import "M3ConstraintStringComponent.h"

@implementation M3ConstraintStringComponentParser

- (M3ConstraintStringComponent *)componentFromString:(NSString *)aComponentString {
	M3ConstraintStringComponent *component = [M3ConstraintStringComponent new];
	
	NSString *keyPathString = nil;
	NSString *attributesString = nil;
	NSString *multiplierString = nil;
	NSString *constantString = nil;
	
	[self tokeniseString:aComponentString keyPath:&keyPathString attributes:&attributesString multiplier:&multiplierString constant:&constantString];
	
	[component setKeyPath:[keyPathString substringFromIndex:1]];
	[component setAttributeList:[self attributeListFromString:attributesString]];
	[component setMultiplier:[self multiplierFromString:multiplierString]];
	[component setConstantList:[self constantListFromString:constantString]];
	
	return component;
}

- (void)tokeniseString:(NSString *)aString keyPath:(NSString **)aKeyPath attributes:(NSString **)aAttributes multiplier:(NSString **)aMultiplier constant:(NSString **)aConstant {
	//If we only have a constant, set the string and return
	if (![aString hasPrefix:@"$"]) {
		*aConstant = aString;
		return;
	}
	
	//Otherwise find the various components
	NSUInteger multiplierIndex = [aString rangeOfString:@"*"].location;
	NSUInteger constantIndex = [aString rangeOfString:@"+"].location;
	if (constantIndex == NSNotFound) {
		constantIndex = [aString rangeOfString:@"-"].location;
	}
	
	//multiplier & constant
	if (constantIndex != NSNotFound && multiplierIndex != NSNotFound) {
		*aMultiplier = [aString substringWithRange:NSMakeRange(multiplierIndex, constantIndex - multiplierIndex)];
		*aConstant = [aString substringFromIndex:constantIndex];
		aString = [aString substringToIndex:multiplierIndex];
	}
	//only multiplier
	else if (multiplierIndex != NSNotFound) {
		*aMultiplier = [aString substringFromIndex:multiplierIndex];
		aString = [aString substringToIndex:multiplierIndex];
	}
	//only constant
	else if (constantIndex != NSNotFound) {
		*aConstant = [aString substringFromIndex:constantIndex];
		aString = [aString substringToIndex:constantIndex];
	}
	
	NSArray *components = [aString componentsSeparatedByString:@"."];
	*aAttributes = components.lastObject;
	*aKeyPath = [[components subarrayWithRange:NSMakeRange(0, components.count - 1)] componentsJoinedByString:@"."];
}

- (NSArray *)attributeListFromString:(NSString *)aString {
	NSString *normalisedAttributeString = [self normaliseAttributeString:aString];
	return [normalisedAttributeString componentsSeparatedByString:@","];
}

- (NSString *)normaliseAttributeString:(NSString *)aString {
	aString = [aString stringByReplacingOccurrencesOfString:@"(" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@")" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@"super" withString:@"top,left,bottom,right"];
	aString = [aString stringByReplacingOccurrencesOfString:@"size" withString:@"width,height"];
	return aString;
}

- (CGFloat)multiplierFromString:(NSString *)aString {
	aString = [aString stringByReplacingOccurrencesOfString:@"*" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	return [aString floatValue];
}

- (NSArray *)constantListFromString:(NSString *)aString {
	aString = [aString stringByReplacingOccurrencesOfString:@"(" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@")" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@"+" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	
	NSMutableArray *constantList = [NSMutableArray array];
	for (NSString *constant in [aString componentsSeparatedByString:@","]) {
		if ([constant isEqualToString:@"-"]) {
			[constantList addObject:constant];
		} else {
			[constantList addObject:@(constant.floatValue)];
		}
	}
	return [constantList copy];
}

@end
