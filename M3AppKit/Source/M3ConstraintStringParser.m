//
//  M3ConstraintStringParser.m
//  M3AppKit
//
//  Created by Martin Pilkington on 24/07/2012.
//  Copyright (c) 2012 M Cubed Software. All rights reserved.
//

#import "M3ConstraintStringParser.h"
#import "M3ConstraintStringComponent.h"
#import "M3ConstraintStringComponentParser.h"

NSException *M3ExceptionWithReason(NSString *aReason) {
	return [NSException exceptionWithName:@"Constraint String Parsing Error" reason:aReason userInfo:nil];
}

@implementation M3ConstraintStringParser {
	NSDictionary *attributeMap;
	M3ConstraintStringComponentParser *componentParser;
}

- (id)initWithSubstitutionViews:(NSDictionary *)aViews {
	if ((self = [super init])) {
		_substitutionViews = aViews;
		attributeMap = @{
			@"left" : @{ @"attribute" : @(NSLayoutAttributeLeft), @"requiresSecondItem" : @YES },
			@"right" : @{ @"attribute" : @(NSLayoutAttributeRight), @"requiresSecondItem" : @YES },
			@"top" : @{ @"attribute" : @(NSLayoutAttributeTop), @"requiresSecondItem" : @YES },
			@"bottom" : @{ @"attribute" : @(NSLayoutAttributeBottom), @"requiresSecondItem" : @YES },
			@"leading" : @{ @"attribute" : @(NSLayoutAttributeLeading), @"requiresSecondItem" : @YES },
			@"trailing" : @{ @"attribute" : @(NSLayoutAttributeTrailing), @"requiresSecondItem" : @YES },
			@"width" : @{ @"attribute" : @(NSLayoutAttributeWidth), @"requiresSecondItem" : @NO },
			@"height" : @{ @"attribute" : @(NSLayoutAttributeHeight), @"requiresSecondItem" : @NO },
			@"centerX" : @{ @"attribute" : @(NSLayoutAttributeCenterX), @"requiresSecondItem" : @YES },
			@"centerY" : @{ @"attribute" : @(NSLayoutAttributeCenterY), @"requiresSecondItem" : @YES },
			@"baseline" : @{ @"attribute" : @(NSLayoutAttributeBaseline), @"requiresSecondItem" : @YES }
		};
		componentParser = [M3ConstraintStringComponentParser new];
	}
	return self;
}

- (NSArray *)constraintsFromString:(NSString *)aString {
	NSLayoutRelation relation = [self relationFromString:aString];
	NSDictionary *relationStrings = @{ @(NSLayoutRelationEqual) : @"=", @(NSLayoutRelationGreaterThanOrEqual) : @">=", @(NSLayoutRelationLessThanOrEqual) : @"<=" };
	NSArray *components = [aString componentsSeparatedByString:relationStrings[@(relation)]];
	if (components.count != 2) {
		return nil;
	}
	
	M3ConstraintStringComponent *firstComponent = [componentParser componentFromString:components[0]];
	M3ConstraintStringComponent *secondComponent = [componentParser componentFromString:components[1]];
	
	
	return [self constraintsWithFirstComponent:firstComponent relation:relation secondComponent:secondComponent];
}

- (NSLayoutRelation)relationFromString:(NSString *)aString {
	if ([aString m3_containsString:@">="]) {
		return NSLayoutRelationGreaterThanOrEqual;
	}
	if ([aString m3_containsString:@"<="]) {
		return NSLayoutRelationLessThanOrEqual;
	}
	return NSLayoutRelationEqual;
}

- (NSArray *)constraintsWithFirstComponent:(M3ConstraintStringComponent *)aFirstComponent relation:(NSLayoutRelation)aRelation secondComponent:(M3ConstraintStringComponent *)aSecondComponent {
	NSMutableArray *constraints = [NSMutableArray array];
	
	NSView *firstItem = [self viewForKeyPath:aFirstComponent.keyPath];
	NSView *secondItem = [self viewForKeyPath:aSecondComponent.keyPath] ?: firstItem.superview;
	
	for (NSUInteger currentAttribute = 0; currentAttribute < aFirstComponent.attributeList.count; currentAttribute++) {
		NSString *firstAttributeString = aFirstComponent.attributeList[currentAttribute];
		NSString *secondAttributeString = @"";
		CGFloat constant = 0.0;
		
		//Do we require a second attribute or are we fine with just a constant?
		if ([attributeMap[firstAttributeString][@"requiresSecondItem"] boolValue]) {
			//If we have no second attributes use the first item
			if (aSecondComponent.attributeList.count == 0) {
				secondAttributeString = firstAttributeString;
			}
			//If we don't have enough second item attributes throw an exception
			else if (aSecondComponent.attributeList.count <= currentAttribute) {
				@throw M3ExceptionWithReason([NSString stringWithFormat:@"No matching attribute for attribute %@", firstAttributeString]);
			}
			//Otherwise get the attribute
			else {
				secondAttributeString = aSecondComponent.attributeList[currentAttribute];
			}
		}
		
		//If we have no constants use 0
		if (aSecondComponent.constantList.count == 0) {
			constant = 0;
		}
		//If we have only 1 constant we assign it to everything
		else if (aSecondComponent.constantList.count == 1) {
			constant = [aSecondComponent.constantList[0] floatValue];
		}
		//If we have multiple constants, but not enough for the attributes throw an exception
		else if (aSecondComponent.constantList.count <= currentAttribute) {
			@throw M3ExceptionWithReason([NSString stringWithFormat:@"No constant for attribute %@", firstAttributeString]);
		}
		//If we have multiple constants and have enough, use the current constant
		else {
			if ([aSecondComponent.constantList[currentAttribute] isEqual:@"-"]) continue;
			constant = [aSecondComponent.constantList[currentAttribute] floatValue];
		}
		
		
		NSLayoutAttribute firstAttribute = [attributeMap[firstAttributeString][@"attribute"] integerValue];
		NSLayoutAttribute secondAttribute = [attributeMap[secondAttributeString][@"attribute"] integerValue];
		
		//If we require a second item then use it, otherwise use nil
		id attributeSecondItem = (secondAttributeString.length ? secondItem : nil);
		
		[constraints addObject:[NSLayoutConstraint constraintWithItem:firstItem attribute:firstAttribute relatedBy:aRelation toItem:attributeSecondItem attribute:secondAttribute multiplier:aSecondComponent.multiplier constant:constant]];
	}
	
	return [constraints copy];
}

- (NSView *)viewForKeyPath:(NSString *)aKeyPath {
	return [self.substitutionViews valueForKeyPath:aKeyPath];
}


@end
