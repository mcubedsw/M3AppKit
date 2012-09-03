//
//  M3ConstraintStringParser.m
//  M3AppKit
//
//  Created by Martin Pilkington on 24/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringParser.h"

NSException *M3ExceptionWithReason(NSString *aReason) {
	return [NSException exceptionWithName:@"Constraint String Parsing Error" reason:aReason userInfo:nil];
}

@implementation M3ConstraintStringParser {
	NSDictionary *attributeMap;
}

- (id)initWithSubstitutionViews:(NSDictionary *)aViews {
	if ((self = [super init])) {
		_substitutionViews = aViews;
		attributeMap = @{
			@"left" : @(NSLayoutAttributeLeft),
			@"right" : @(NSLayoutAttributeRight),
			@"top" : @(NSLayoutAttributeTop),
			@"bottom" : @(NSLayoutAttributeBottom),
			@"leading" : @(NSLayoutAttributeLeading),
			@"trailing" : @(NSLayoutAttributeTrailing),
			@"width" : @(NSLayoutAttributeWidth),
			@"height" : @(NSLayoutAttributeHeight),
			@"centerX" : @(NSLayoutAttributeCenterX),
			@"centerY" : @(NSLayoutAttributeCenterY),
			@"baseline" : @(NSLayoutAttributeBaseline)
		};
	}
	return self;
}

- (NSArray *)constraintsFromString:(NSString *)aString {
	return nil;
}

@end
