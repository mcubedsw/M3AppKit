/*****************************************************************
 M3ConstraintStringComponentParser.m
 M3AppKit
 
 Created by Martin Pilkington on 03/09/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringComponentParser.h"
#import "M3ConstraintStringComponent.h"
#import "M3ConstraintStringComponentTokeniser.h"

@implementation M3ConstraintStringComponentParser

- (M3ConstraintStringComponent *)componentFromString:(NSString *)aComponentString {
	M3ConstraintStringComponentTokeniser *tokeniser = [M3ConstraintStringComponentTokeniser tokeniseString:aComponentString];
	
	M3ConstraintStringComponent *component = [M3ConstraintStringComponent new];
	[component setKeyPath:tokeniser.keypathString];
	[component setAttributeList:[self attributeListFromString:tokeniser.attributeString]];
	[component setMultiplier:[self multiplierFromString:tokeniser.multiplierString]];
	[component setConstantList:[self constantListFromString:tokeniser.constantString]];
	
	return component;
}

- (NSArray *)attributeListFromString:(NSString *)aString {
	//Returns an attribute list
	NSString *normalisedAttributeString = [self normaliseAttributeString:aString];
	return [normalisedAttributeString componentsSeparatedByString:@","];
}

- (NSString *)normaliseAttributeString:(NSString *)aString {
	//Removes any extraneous characters and expands keywords
	aString = [aString stringByReplacingOccurrencesOfString:@"(" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@")" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@"margin" withString:@"top,leading,bottom,trailing"];
	aString = [aString stringByReplacingOccurrencesOfString:@"size" withString:@"width,height"];
	aString = [aString stringByReplacingOccurrencesOfString:@"center" withString:@"centerX,centerY"];
	return aString;
}

- (CGFloat)multiplierFromString:(NSString *)aString {
	//Extracts the multiplier
	if (!aString.length) {
		return 1;
	}
	aString = [aString stringByReplacingOccurrencesOfString:@"*" withString:@""];
	aString = [aString stringByReplacingOccurrencesOfString:@" " withString:@""];
	return [aString floatValue];
}

- (NSArray *)constantListFromString:(NSString *)aString {
	//Extracts constant values from a constant list
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
