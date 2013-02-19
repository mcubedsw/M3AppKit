/*****************************************************************
 M3ConstraintStringParser.m
 M3AppKit
 
 Created by Martin Pilkington on 24/07/2012.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringParser.h"
#import "M3ConstraintStringComponent.h"
#import "M3ConstraintStringComponentParser.h"
#import "M3ConstraintStringUtilities.h"

NSDictionary *M3SubstitutionViewsWithCollection(id aCollection, NSView *aSelfView) {
	NSMutableDictionary *views = [NSMutableDictionary dictionaryWithObject:aSelfView forKey:@"self"];
	
	if ([aCollection isKindOfClass:[NSDictionary class]]) {
		[views addEntriesFromDictionary:aCollection];
	}
	if ([aCollection isKindOfClass:[NSArray class]]) {
		[aCollection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
			[views setObject:obj forKey:[NSString stringWithFormat:@"%ld", idx]];
		}];
	}
	
	return [views copy];
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
	NSArray *components = [self componentsFromString:aString];
	
	NSLayoutRelation relation = [self relationFromString:components[1]];
	CGFloat priority = [self priorityFromString:components[1]];
	
	M3ConstraintStringComponent *firstComponent = [componentParser componentFromString:components[0]];
	M3ConstraintStringComponent *secondComponent = [componentParser componentFromString:components[2]];
	
	
	return [self constraintsWithFirstComponent:firstComponent relation:relation secondComponent:secondComponent priority:priority];
}

- (NSArray *)componentsFromString:(NSString *)aString {
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([a-zA-Z0-9\\s.$_(),]*)((?:>|<){0,1}=(?:\\(@\\d*\\)){0,1})(.*)" options:0 error:NULL];
	NSArray *matches = [regex matchesInString:aString options:0 range:NSMakeRange(0, aString.length)];
	
	if (matches.count != 1) M3ExceptionWithReason([NSString stringWithFormat:@"Invalid equation string '%@'", aString]);
	
	NSTextCheckingResult *match = matches[0];
	
	return @[
		[aString substringWithRange:[match rangeAtIndex:1]],
		[aString substringWithRange:[match rangeAtIndex:2]],
		[aString substringWithRange:[match rangeAtIndex:3]]
	];
}

- (NSLayoutRelation)relationFromString:(NSString *)aString {
	if ([aString hasPrefix:@">="]) {
		return NSLayoutRelationGreaterThanOrEqual;
	}
	if ([aString hasPrefix:@"<="]) {
		return NSLayoutRelationLessThanOrEqual;
	}
	return NSLayoutRelationEqual;
}

- (CGFloat)priorityFromString:(NSString *)aString {
	NSUInteger index = [aString rangeOfString:@"@"].location;
	if (index == NSNotFound) return 1000;
	
	NSString *priorityString = [aString substringFromIndex:index + 1];
	
	if ([priorityString hasSuffix:@")"]) priorityString = [priorityString m3_stringByRemovingCharactersFromEnd:1];
	
	return priorityString.floatValue;
}

- (NSArray *)constraintsWithFirstComponent:(M3ConstraintStringComponent *)aFirstComponent relation:(NSLayoutRelation)aRelation secondComponent:(M3ConstraintStringComponent *)aSecondComponent priority:(CGFloat)aPriority {
	NSMutableArray *constraints = [NSMutableArray array];
	
	NSArray *firstItems = [self viewForKeyPath:aFirstComponent.keyPath];
	NSArray *secondItems = [self viewForKeyPath:aSecondComponent.keyPath];
	NSView *secondView = nil;
	if (secondItems.count == 1) {
		secondView = secondItems[0];
	}
	
	for (NSView *firstView in firstItems) {
		for (NSUInteger currentAttribute = 0; currentAttribute < aFirstComponent.attributeList.count; currentAttribute++) {
			NSString *firstAttributeString = aFirstComponent.attributeList[currentAttribute];
			NSString *secondAttributeString = @"";
			CGFloat constant = 0.0;
			
			//Do we require a second attribute or are we fine with just a constant?
			if ([attributeMap[firstAttributeString][@"requiresSecondItem"] boolValue] && !secondView)  {
				secondView = firstView.superview;
			}
//				//If we have no second attributes use the first item
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
//			}
			
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
			id attributeSecondItem = (secondAttributeString.length ? secondView : nil);
			
			NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:firstView
																		  attribute:firstAttribute
																		  relatedBy:aRelation
																			 toItem:attributeSecondItem
																		  attribute:secondAttribute
																		 multiplier:aSecondComponent.multiplier
																		   constant:constant];
			[constraint setPriority:aPriority];
			[constraints addObject:constraint];
		}
	}
	
	return [constraints copy];
}

- (NSArray *)viewForKeyPath:(NSString *)aKeyPath {
	if ([aKeyPath isEqualToString:@"all"]) {
		NSMutableDictionary *views = [self.substitutionViews mutableCopy];
		[views removeObjectForKey:@"self"];
		return views.allValues;
	}
	NSView *view = [self.substitutionViews valueForKeyPath:aKeyPath];
	if (!view) {
		return nil;
	}
	return @[ view ];
}


@end
