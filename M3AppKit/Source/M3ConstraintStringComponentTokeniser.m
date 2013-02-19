/*****************************************************************
 M3ConstraintStringComponentTokeniser.m
 M3AppKit
 
 Created by Martin Pilkington on 18/02/2013.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/

#import "M3ConstraintStringComponentTokeniser.h"
#import "M3ConstraintStringUtilities.h"

@implementation M3ConstraintStringComponentTokeniser {
	NSUInteger currentIndex;
	NSInteger bracketLevel;
	BOOL multiplierIsSuffix;
}

+ (instancetype)tokeniseString:(NSString *)aString {
	M3ConstraintStringComponentTokeniser *tokeniser = [[self alloc] initWithString:aString];
	[tokeniser tokenise];
	return tokeniser;
}

- (id)initWithString:(NSString *)aString {
	if ((self = [super init])) {
		_string = [self stringByStrippingWhitespace:aString];
	}
	return self;
}

- (NSString *)stringByStrippingWhitespace:(NSString *)aString {
	NSMutableString *mutableString = [aString mutableCopy];
	[mutableString replaceOccurrencesOfString:@" " withString:@"" options:0 range:NSMakeRange(0, mutableString.length)];
	[mutableString replaceOccurrencesOfString:@"\t" withString:@"" options:0 range:NSMakeRange(0, mutableString.length)];
	[mutableString replaceOccurrencesOfString:@"\n" withString:@"" options:0 range:NSMakeRange(0, mutableString.length)];
	return [mutableString copy];
}

- (void)tokenise {
	[self reset];
	
	[self findPrefixMultiplier];
	[self findViewAttributeString];
	[self findSuffixMultiplier];
	
	//Reset the search if we don't have a view attribute string, as it's just a constant
	if (!self.keypathString.length) [self reset];
	
	[self findConstant];

	//Handle bracket mismatches
	if (bracketLevel > 0) @throw M3ExceptionWithReason([NSString stringWithFormat:@"Missing ')' in component '%@'", self.string]);
	if (bracketLevel < 0) @throw M3ExceptionWithReason([NSString stringWithFormat:@"Extraneous ')' found in component '%@'", self.string]);
}

- (void)findPrefixMultiplier {
	NSMutableString *multiplerString = [NSMutableString string];
	for (; currentIndex < self.string.length; currentIndex++) {
		if ([@[@"*", @"+", @"-"] containsObject:self.currentCharacter]) break;
		if ([self.currentCharacter isEqualToString:@"("]) break;
		if ([self.currentCharacter isEqualToString:@"$"]) break;
		
		if (self.currentCharacter) [multiplerString appendString:self.currentCharacter];
	}
	_multiplierString = [multiplerString copy];
}

- (void)findViewAttributeString {
	NSMutableString *viewAttributeString = [NSMutableString string];
	
	BOOL foundDollar = NO; //If we dont' find a dollar then this won't be a view attribute string, instead may be a constant
	
	for (; currentIndex < self.string.length; currentIndex++) {
		if ([self.currentCharacter isEqualToString:@"$"]) {
			foundDollar = YES;
			continue;
		}
		if ([self.currentCharacter isEqualToString:@"("]) bracketLevel++;
		if ([self.currentCharacter isEqualToString:@")"]) bracketLevel--;
		if ([@[@"*", @"+", @"-"] containsObject:self.currentCharacter]) break;
		
		if (self.currentCharacter) [viewAttributeString appendString:self.currentCharacter];
	}
	
	if ([viewAttributeString hasPrefix:@"("] && [viewAttributeString hasSuffix:@")"]) {
		viewAttributeString = [[viewAttributeString substringWithRange:NSMakeRange(1, viewAttributeString.length - 2)] mutableCopy];
	}
	
	NSMutableArray *components = [[viewAttributeString componentsSeparatedByString:@"."] mutableCopy];
	NSString *attributeString = components.lastObject;
	[components removeLastObject];
	NSString *keypathString = [components componentsJoinedByString:@"."];
	
	if (foundDollar) {
		_keypathString = [keypathString copy];
		_attributeString = [attributeString copy];
	}
}

- (void)findSuffixMultiplier {
	NSMutableString *multiplierString = [NSMutableString string];
	for (; currentIndex < self.string.length; currentIndex++) {
		if ([self.currentCharacter isEqualToString:@"*"]) continue;
		if ([@[@"+", @"-"] containsObject:self.currentCharacter]) break;
		
		if (self.currentCharacter) [multiplierString appendString:self.currentCharacter];
		
	}
	
	if (self.multiplierString.length && multiplierString.length) {
		@throw M3ExceptionWithReason([NSString stringWithFormat:@"Cannot have two multipliers in component '%@'", self.string]);
	}
	
	if (multiplierString.length) {
		multiplierIsSuffix = YES;
		_multiplierString = [multiplierString copy];
	}
}

- (void)findConstant {
	NSMutableString *constantString = [NSMutableString string];
	for (; currentIndex < self.string.length; currentIndex++) {
		if ([self.currentCharacter isEqualToString:@"+"]) continue;
		if ([self.currentCharacter isEqualToString:@")"]) bracketLevel--;
		if ([self.currentCharacter isEqualToString:@"("]) bracketLevel++;
		
		if (self.currentCharacter) [constantString appendString:self.currentCharacter];
	}
	
	_constantString = [constantString copy];
}

- (NSString *)currentCharacter {
	if (currentIndex >= self.string.length) return nil;
	return [self.string substringWithRange:NSMakeRange(currentIndex, 1)];
}

- (void)reset {
	currentIndex = 0;
	bracketLevel = 0;
	_multiplierString = @"";
	_keypathString = @"";
	_constantString = @"";
}

@end
